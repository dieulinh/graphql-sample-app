# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
# include SendGrid
class SendgridWrapper
  include SendGrid
  def send_mail(send_from:, send_to:, subject:, template_id: , substitution_data:)
    to = Email.new(email: send_to)
    mail = SendGrid::Mail.new
    mail.from = Email.new(email: send_from)
    mail.subject = subject
    personalization = Personalization.new
    personalization.add_to(to)
    personalization.add_substitution(Substitution.new(substitution_data))
    mail.add_personalization(personalization)
    mail.template_id = template_id

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    begin
      response = sg.client.mail._("send").post(request_body: mail.to_json)
    rescue Exception => e
      puts e.message
    end
    puts response.status_code
    puts response.body
    puts response.parsed_body
    response.status_code
  end
end


