class SendmailWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: :default
  def perform(user_id, *args)
    user = Student.find(user_id)
    begin
      user.generate_password_token!
      substitution_data = { key: '-reset_token-', value: user.reset_password_token}
      SendgridWrapper.new.send_mail(send_from: ENV['SENDGRID_SENDER'], send_to: user.email, subject: 'Reset Password Request', template_id: ENV['RESET_PASSWORD_TEMPLATE_ID'], substitution_data: substitution_data)
    rescue => err
      puts err
    end
  end
end
