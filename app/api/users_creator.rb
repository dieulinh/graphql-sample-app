class UsersCreator < Grape::API
  include Shared::AuthorizationKit
  namespace :users do
    params do
      optional :email, type: String
      requires :token, type: String
    end
    post '/activate' do

      Rails.logger.info(params)

    end
  end
end
