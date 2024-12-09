class VerificationMailer < ApplicationMailer
  def send_code(email:, code:)
    @code = code
    mail(to: email, subject: 'You are requesting download a resume in our system', body: "Your code is: #{code}")
  end
end
