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
      search_params = {specialization_or_bio_cont: params[:q]}
      search_params = search_params.merge(country_eq: params[:country]) if params[:country].present?
      mentors = Mentor.ransack(search_params)

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
      optional :hourly_rate, type: Integer
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
    params do
      requires :company_name, type: String
      optional :position, type: String
      optional :start_date, type: Date
      optional :end_date, type: Date
      requires :responsibilities, type: String
    end
    post '/:id/works' do
      authenticate_user!
      mentor = Mentor.find(params.delete(:id))
      # authorize mentor, :update?
      work = mentor.work_histories.build(params)
      if work.save
        return { work_history: mentor.work_histories }.as_json
      else
        return { error: 'not found'}
      end
    end

    get '/:id/works' do
      mentor = Mentor.find(params[:id])
      byebug
      # authorize mentor, :update?
      works = mentor.work_histories
      { work_histories: works }.as_json
    end
  end
end
