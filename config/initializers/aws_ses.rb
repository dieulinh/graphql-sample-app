creds = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'],
  ENV['AWS_SECRET_KEY'])
Aws::Rails.add_action_mailer_delivery_method(:aws_sdk,
                  credentials: creds,
                  region: 'us-west-2')
