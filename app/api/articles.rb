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
      images = post_params[:images]
      new_urls = []
      images.each do |img_url|
        a_photo = AttachedPhoto.new
        # tempfile = URI.parse(img_url).read

        # uploader = AttachmentUploader.new
        # uploader.store! tempfile
        # byebug
        a_photo.photo = URI.parse(img_url)

        new_urls.push a_photo.photo.web.url
      end


      images_str = new_urls.length > 0 ? new_urls.map{|url| "<img src=\"#{url}\" \/>"}.join("") : ""
      post.content = post.content + images_str
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
