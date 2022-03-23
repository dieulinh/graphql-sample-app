class ApplicationMailer < ActionMailer::Base
  default from: ENV['AWS_SENDER_EMAIL']
  layout 'mailer'

end
