class Verifications < Grape::API
  namespace :verifications do
    params do
      requires :email, type: String
    end
    post '/send_verification_code' do
      email = params[:email]
      code = Verification.generate_code(email).code
      VerificationMailer.send_code(email: email, code: code).deliver
      { status: 201 }
    end
    params do
      requires :email, type: String
      requires :code, type: String
    end

    post '/verify_code' do
      email = params[:email]
      code = params[:code]
      url = SendResume.new(email, code).call
      return { status: 500 } unless url
      { status: 200, url: url }

    end
  end
end
