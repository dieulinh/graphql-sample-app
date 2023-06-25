class Mentors < Grape::API
  include Shared::AuthorizationKit
  namespace :mentors do
    params do
      requires :first_name, type: String
      requires :last_name, type: String
      requires :email, type: String
      requires :specialization, type: String
      optional :bio, type: String
      optional :experience_years, type: Integer
    end

    post '/' do
      authenticate_user!
      post = Mentor.create(title: params[:lesson][:title], content: params[:lesson][:content].html_safe, published: params[:lesson][:published])
      present post
    end
    # index
    params do
      optional :page, type: Integer
    end
    get '/' do
      present Mentor.all
    end

    get '/:id' do
      present {mentor: Mentor.find(params[:id])}
    end
  end
end