class Auth < Grape::API
  namespace :login do
    desc 'Login endpoint'
    params do
      requires :email, type: String
      requires :password, type: String
    end
    post '/' do
      user = Student.find_by(email: params[:email].downcase)
      return unauthorized! unless user && user.authenticate(params[:password])
      encoded_user = ::JsonWebToken.encode(user_id: user.id) if user
      present encoded_user
    end

    desc 'Register endpoint'
    params do
      requires :email, type: String
      requires :password, type: String
      requires :password_confirmation, type: String
    end
    post '/register' do
      return render_api_error!('password and password confirmation does not match', 422) unless params[:password] == params[:password_confirmation]
      email = params[:email].downcase
      user = Student.find_by(email: email)
      return render_api_error!('User existed', 422) if user
      user = Student.create(email: email, password: params[:password], password_confirmation: params[:password_confirmation])
      present user, status: 201
    end

    desc 'Reset password'
    params do
      requires :email, type: String
    end
    post '/reset_password' do

      email = params[:email].downcase
      user = Student.find_by(email: email)
      if user
        UserMailer.with(user: user).reset_password.deliver_later
      end

      present user, status: 201
    end
  end
end
