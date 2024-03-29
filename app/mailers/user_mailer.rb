class UserMailer < ApplicationMailer
  def reset_password
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def send_contact_form(inquiry)
    @inquiry = inquiry
    mail(to: ENV['NOTIFIED_ADMIN_EMAIL'], subject: "Contact message from #{inquiry.email}")
  end
end
