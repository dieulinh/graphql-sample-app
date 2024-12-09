class Verifications < Grape::API
  namespace :verifications do
    params do
      requires :email, type: String
    end
    post '/send_verification_code' do
      email = params[:email]
      code = Verification.generate_code(email).code

      VerificationMailer.send_code(email: email, code: code).deliver_later

      { status: 201 }
    end
    params do
      requires :email, type: String
      requires :code, type: String
    end

    post '/verify_code' do

      email = params[:email]
      code = params[:code]

      if Verification.valid_code?(email, code)
        s3_client = Aws::S3::Client.new(region: ENV['PERSONAL_DOCS_REGION'], access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_KEY'])
        signer = Aws::S3::Presigner.new(client: s3_client)
        url = signer.presigned_url(:get_object, bucket: ENV['PERSONAL_BUCKET_NAME'], key: 'resume.pdf', expires_in: 20)

        { status: 200, url: url }
      else
        { status: 400 }
      end
    end
  end
end
