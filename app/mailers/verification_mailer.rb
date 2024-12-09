class VerificationMailer < ApplicationMailer

  def notify_resume_downloaded(email:)
    mail(to: ENV['AWS_SENDER_EMAIL'], subject: "Your resume has been downloaded #{email}")
  end
  def send_code(email:, code:)
    @code = code
    mail(to: email, subject: 'You are requesting download a resume in our system', body: "Your code is: #{code}")
  end
end
