class Articles < Grape::API
  include Shared::AuthorizationKit
  namespace :articles do
    params do
      requires :title, type: String
      requires :content, type: String
      optional :file, type: File
    end

    post '/' do
      authenticate_user!
      post = Article.create(params)
      present post
    end

    params do
      requires :article_url, type: String

    end

    post '/add_custom' do
      authenticate_user!

      post_params = WebScraper.parse_article(params[:article_url])
      post = Article.new(post_params.except(:images))
      post.content = post.content + BulkUploadImages.call(post_params[:images])
      post.save

      present post
    end

    get '/' do
      articles = Article.order('created_at desc')
      present articles
    end

    get '/:post_id' do
      article = Article.find(params[:post_id])
      present article
    end
  end
end
