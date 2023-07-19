# require 'sidekiq/web'
# Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]
# Sidekiq::Web.set :sessions,       Rails.application.config.session_options
Rails.application.routes.draw do
  # mount Sidekiq::Web => '/sidekiq'
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  mount API => '/api'
  root to: 'home#index'
  get 'about', to: 'home#show'
  match '*path' => redirect('/'), :via => [:get, :post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
