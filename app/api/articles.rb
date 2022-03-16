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

    get '/' do
      articles = Article.order('created_at desc')
      present articles
    end
  end
end
