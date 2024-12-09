class SendResume
  def initialize(email, code)
    @email = email
    @code = code
  end
  def call
    return nil unless Verification.valid_code?(@email, @code)
    VerificationMailer.notify_resume_downloaded(email: @email).deliver
    s3_client = Aws::S3::Client.new(region: ENV['PERSONAL_DOCS_REGION'], access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_KEY'])
    signer = Aws::S3::Presigner.new(client: s3_client)
    url = signer.presigned_url(:get_object, bucket: ENV['PERSONAL_BUCKET_NAME'], key: 'resume.pdf', expires_in: 20)
    url
  end
end