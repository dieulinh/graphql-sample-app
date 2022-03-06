class Articles < Grape::API
  include Shared::AuthorizationKit
  namespace :articles do
    params do
      requires :title, type: String
      requires :content, type: String
      optional :file, type: File
      optional :published, type: Boolean
    end

    post '/' do
      authenticate_user!
      byebug
      post = Article.create(params)
      present post
    end

    get '/' do
      authenticate_user!
      articles = Article.all
      present articles
    end
  end
end
