class Learns < Grape::API
  include Shared::AuthorizationKit
  namespace :learns do
    params do
      requires :prompt, type: String
    end
    post '/vocabs' do
      authenticate_user!
      rs = OpenaiService.new.call(params[:prompt])
      { vocabs: rs['choices'][0]['message']['content'] }
    end

  end
end