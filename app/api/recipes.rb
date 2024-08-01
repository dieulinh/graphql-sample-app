class Recipes < Grape::API
  include Shared::AuthorizationKit
  namespace :recipes do
    get '/' do
      { recipes: Recipe.all }
    end
    params do
      requires :title, type: String
      requires :instructions, type: String
      requires :description, type: String
    end

    post '/' do
      authenticate_user!
      post = Recipe.create(params)
      present post
    end
  end
end
