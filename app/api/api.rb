require 'grape-swagger'

class API < Grape::API
  format :json
  rescue_from :all, backtrace: true
  helpers ::Shared::Helpers

  format :json
  mount Auth
  mount Uploads
  mount Lessons

  rescue_from Grape::Exceptions::ValidationErrors  do |e|
    rack_response({
      status: e.status,
      error_msg: e.message
  }.to_json, 400)
  end
end
