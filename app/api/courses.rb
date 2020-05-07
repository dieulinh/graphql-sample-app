class Courses < Grape::API
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
                courseCoverUrl
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
      requires :course_name, type: String
      optional :course_cover, type: File
      optional :description, type: String
    end

    post '/' do
      course = Course.new(course_name: params[:course_name], description: params[:description], author_id: current_user.id)
      course.course_cover.attach(io: File.open(params[:course_cover][:tempfile]), filename: params[:course_cover][:filename], content_type: params[:course_cover][:type]) if params[:course_cover]
      course.save
      present course
    end

    get '/:course_id' do
      course = Course.find(params[:course_id])
      present course.attributes.merge("course_cover" => course.course_cover_url)
    end
  end
end
