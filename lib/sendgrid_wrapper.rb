# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
# include SendGrid
class SendgridWrapper
  # require 'sendgrid-ruby'
  include SendGrid
  def send_mail(send_from:, send_to:, subject:, sending_content:)
    from = Email.new(email: send_from)
    to = Email.new(email: send_to)
    # subject = 'Sending with SendGrid is Fun'
    content = Content.new(type: 'text/plain', value: sending_content)
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end
end


