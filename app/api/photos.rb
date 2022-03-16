class Photos < Grape::API
  include Shared::AuthorizationKit
  namespace :photos do
    params do
      requires :file, type: File
    end
    post '/' do
      attachment = AttachedPhoto.new
      attachment.photo = params[:file]
      attachment.save
      present attachment
    end
  end
end
