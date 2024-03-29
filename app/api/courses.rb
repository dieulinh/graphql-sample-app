class Courses < Grape::API
  include Shared::AuthorizationKit
  namespace :courses do
    params do
      optional :item_per_page, type: Integer
      optional :offset, type: Integer
    end
    get '/' do
      query = %Q(
        query {
          coursesConnection {
            pageInfo {
              endCursor
              hasNextPage
            }
            edges {
              node {
                id
                courseName
                description
                status
              }
              cursor
            }
          }
        }
      )
      result = RailsWebTemplateSchema.execute(query, variables: {}, context: {}, operation_name: nil)
      result
    end

    params do
      requires :term, type: String
      optional :page, type: Integer
      optional :user_id, type: String
    end
    get '/search' do
      page = params[:page] || 1
      search_params = { course_name_or_description_matches: "%#{params[:term]}%" }
      if params[:user_id]
        user_courses = CourseUser.where(student_id: params[:user_id].to_i).pluck(:course_id).uniq
        search_params = search_params.merge(id_in: user_courses)
      end

      courses = Course.ransack(search_params)
      { courses: courses.result.page(page) }.as_json
    end

    params do
      requires :course_name, type: String
      requires :description, type: String
      optional :course_cover, type: File
    end

    post '/' do
      authenticate_user!
      course = Course.new(params.except(:course_cover))
      course.author_id = current_user.id
      course.course_cover.attach(io: File.open(params[:course_cover][:tempfile]), filename: params[:course_cover][:filename], content_type: params[:course_cover][:type]) if params[:course_cover]
      course.save
      present course
    end

    get '/:course_id' do
      course = Course.friendly.find(params[:course_id])
      sections = []
      if current_user.present?
        sections = course.posts.order('created_at asc') if current_user.roles.include?('subscriber')||current_user.roles.include?('admin')
      end
      present course.attributes.merge("sections" => sections)
    end

    params do
      optional :course_name, type: String
      optional :course_cover, type: File
      optional :description, type: String
      optional :status_update, type: Boolean
    end
    put '/:id' do
      authenticate_user!
      course = Course.find(params[:id])
      authorize course, :update?
      unless params[:status_update]
        course.course_cover.attach(io: File.open(params[:course_cover][:tempfile]), filename: params[:course_cover][:filename], content_type: params[:course_cover][:type]) if params[:course_cover]
        course_params = params.except(:course_cover)
        course_params = course_params.merge(description: params[:description].html_safe) if params[:description]
      else
        course_params = {status: (course.pending? ? :published : :pending) }
      end
      course.attributes = course_params
      course.save
      present course
    end
    params do
      requires :lesson, type: Hash do
        requires :title, type: String
        requires :content, type: String
        requires :price, type: Integer
        optional :file, type: File
        optional :published, type: Boolean
      end
    end

    post '/:course_id/lessons' do
      authenticate_user!
      course = Course.find(params[:course_id])
      authorize course, :update?
      post = course.posts.create(title: params[:lesson][:title], content: params[:lesson][:content].html_safe, published: params[:lesson][:published])
      present post
    end

    desc 'lesson content'
    get '/:course_id/lessons/:lesson_id' do
      course = Course.find(params[:course_id])
      lesson = course.posts.find(params[:lesson_id])
      present lesson
    end
    desc 'update lesson content'
    params do
      requires :title, type: String
      requires :content, type: String
      optional :published, type: Boolean
    end
    put '/:course_id/lessons/:lesson_id' do
      authenticate_user!
      course = Course.find(params[:course_id])
      authorize course, :update?
      lesson = course.posts.find(params[:lesson_id])
      lesson_params = declared(params)
      lesson_params = lesson_params.merge(content: params[:content].html_safe) if params[:content].html_safe
      lesson.update lesson_params
      present lesson
    end

    desc 'detail course'
    get '/:course_id/details' do
      course = Course.friendly.find(params[:course_id])
      sections = []
      if current_user.present?
        sections = course.posts.order('created_at asc') if current_user.roles.include?('subscriber')||current_user.roles.include?('admin')
      end

      { course: course.attributes.merge("course_cover" => course.course_cover_url, "sections" => sections) }.as_json
    end
  end
end
