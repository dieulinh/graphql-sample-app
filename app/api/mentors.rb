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
      search_params = { specialization_or_bio_matches: "%#{params[:q]}%" }
      search_params = search_params.merge(country_eq: params[:country]) if params[:country].present? && params[:country] != 'all'
      mentors = Mentor.ransack(search_params)

      present mentors.result.page(page)
    end

    get '/:id' do
      mentor = Mentor.find(params[:id])
      mentor_att = {}.tap do |rs|
        mentor.attributes.each { |at, v| rs[at.camelize(:lower)] = v }
      end
      { mentor: mentor_att.merge(works: mentor.work_histories) }.as_json
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
        params.except(:works).each { |k, v| h[k.underscore] = v }
      end
      mentor = Mentor.find(params[:id])

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

    desc 'get work information'
    get '/:id/works' do
      mentor = Mentor.find(params[:id])

      works = mentor.work_histories
      { work_histories: works }.as_json
    end

    desc 'book mentor'
    params do
      requires :slot, type: Integer
      requires :date, type: Date
    end

    post '/:id/book' do
      authenticate_user!

      mentor = Mentor.find(params.delete(:id))
      # authorize mentor, :update?
      booking = mentor.bookings.create(student_id: current_user.id, booking_date: params[:date], slot: params[:slot])
      { booking: booking }
    end

    desc 'gallery image for mentor work'
    params do
      requires :image, type: File
      requires :title, type: String
      optional :description, type: String
    end
    post '/:id/gallery' do
      authenticate_user!
      mentor = Mentor.find(params.delete(:id))
      photo = mentor.gallery_images.build(params.except(:image))

      photo.image = params[:image]
      photo.save
      { image: photo }.as_json
    end
  end
end
