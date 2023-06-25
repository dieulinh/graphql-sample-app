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
      { mentor: Mentor.find(params[:id]) }.as_json
    end
    params do
      optional :first_name, type: String
      optional :last_name, type: String
      optional :email, type: String
      optional :phone, type: String
      optional :specialization, type: String
      optional :bio, type: String
      optional :experience_years, type: Integer
      optional :address, type: String
    end
    put '/:id' do
      authenticate_user!
      mentor =  Mentor.find(params[:id])
      # authorize mentor, :update?
      mentor.update(params)
      { mentor: mentor }.as_json
    end
  end
end