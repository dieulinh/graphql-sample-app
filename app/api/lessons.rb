class Lessons < Grape::API
  namespace :lessons do

    params do
      requires :lesson, type: Hash do
        requires :title, type: String
        requires :content, type: String
        optional :file, type: File
        optional :published, type: Boolean
      end
    end

    post '/' do
      post = Post.create(title: params[:lesson][:title], content: params[:lesson][:content].html_safe, published: params[:lesson][:published])
      present post
    end
  end
end
