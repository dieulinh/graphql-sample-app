class PdfExporter < Grape::API
  include Shared::AuthorizationKit
  namespace :pdf_export do
      params do
        optional :email, type: String
        requires :mentor_id, type: Integer
      end
      post '/' do
        authenticate_user!

        Rails.logger.info(params)
        mentor = current_user.mentor
        export(mentor)
      end
  end
end
