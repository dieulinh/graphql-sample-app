class Inquiries < Grape::API
  namespace :inquiries do
    params do
      requires :email, type: String
      requires :content, type: String
    end
    post '/' do
      return bad_request!('ip_address') unless env['REMOTE_ADDR']
      prev_in = Inquiry.where(ip_address: env['REMOTE_ADDR']).order('created_at desc').first
      if prev_in
        if (DateTime.now.utc - prev_in.created_at)/1.minutes < 1
          return bad_request!('ip address')
        end
      end
      inquiry = Inquiry.new(params.merge(ip_address: env['REMOTE_ADDR']))
      inquiry.save

      UserMailer.send_contact_form(inquiry).deliver
      present inquiry
    end


  end
end

# ses.send_email(
#   :to        => ['example@gmail.com'],
#   :source    => '"Linh Nguyen" <example@gmail.com>',
#   :subject   => 'Subject Line',
#   :text_body => 'Internal text body'
# )
# AWS::SES::ResponseError (AWS::SES Response Error: InvalidClientTokenId - Signature Version 3 requests are deprecated from March 1, 2021. From that date on, we are progressively rejecting such requests. To resolve the issue you must migrate to Signature Version 4. If you are self-signing your requests, refer to the documentation for Authenticating requests to the Amazon SES API [1] with Signature Version 4 [2]. If you are not self-signing your requests, simply update your SDK/CLI to the latest version. [1] https://docs.aws.amazon.com/ses/latest/DeveloperGuide/using-ses-api-authentication.html [2] https://docs.aws.amazon.com/general/latest/gr/sigv4-create-canonical-request.html)