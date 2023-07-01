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
      optional :specialization, type: String
      optional :bio, type: String
      optional :experience_years, type: Integer
      optional :address, type: String
      optional :country, type: String
      optional :q, type: String
    end
    get '/' do
      page = params[:page] || 1
      mentors = Mentor.ransack(country: params[:country], specialization_or_bio_cont: params[:q])

      present mentors.result.page(page)
    end

    get '/:id' do
      mentor_att = {}.tap do |rs|
        Mentor.find(params[:id]).attributes.each { |at, v| rs[at.camelize(:lower)] = v }
      end
      { mentor: mentor_att }.as_json
    end

    params do
      optional :first_name, type: String
      optional :last_name, type: String
      optional :email, type: String
      optional :phone, type: String
      optional :specialization, type: String
      # optional :skills, type: String
      optional :country, type: String
      optional :bio, type: String
      optional :experience_years, type: Integer
      optional :address, type: String
    end
    put '/:id' do
      authenticate_user!
      updating_params = {}.tap do |h|
        params.each {|k,v| h[k.underscore] = v}
      end
      mentor = Mentor.find(params[:id])
      # authorize mentor, :update?
      mentor.update(updating_params)
      { mentor: mentor }.as_json
    end
  end
end
