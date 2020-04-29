class Lessons < Grape::API
  namespace :lessons do

    params do
      requires :lesson, type: Hash do
        requires :title, type: String
        requires :content, type: String
        optional :file, type: File
      end
    end

    post '/' do
      post = Post.create(title: params[:lesson][:title], content: params[:lesson][:content].html_safe)
      present post
    end
  end
end
