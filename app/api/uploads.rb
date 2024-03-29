class Uploads < Grape::API
  namespace :uploads do
    params do
      requires :file, type: File
    end
    post '/' do
      # Create a S3 client
      authenticate_user!
      region = ENV['AWS_REGION']
      client = Aws::S3::Client.new(region: region, credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_KEY']))

      bucket = ENV['AWS_S3_BUCKET']
      # Sets a bucket to public-read
      object_key = params[:file][:filename]
      # Put an object in the public bucket
      client.put_object({
        bucket: bucket,
        key: object_key,
        body: (params[:file][:tempfile]),
        acl: 'public-read'
      })
      # Setting the object to public-read
      client.put_object_acl({
        acl: "public-read",
        bucket: bucket,
        key: object_key,
      })
      present "http://#{bucket}.s3-#{region}.amazonaws.com/#{object_key}"
    end
  end
end
