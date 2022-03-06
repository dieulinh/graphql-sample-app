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
      encoded_user = ::JsonWebToken.encode(user_id: user.id, email: user.email) if user
      encoded_expiry = ::JsonWebToken.meta[:exp]
      { token: encoded_user, auth_token_expiry: encoded_expiry }
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
        user.generate_password_token!
        SendmailWorker.perform_async(user.id)
        present status: 200
      else
        present not_found!
      end
    end
    params do
      requires :reset_password_token, type: String, desc: 'Reset password token'
    end
    get '/validates/:reset_password_token' do
      present not_found! unless Student.find_by_reset_password_token params[:reset_password_token]
      present status: 200
    end
    params do
      requires :reset_password_token, type: String, desc: 'Reset password token'
      requires :password, type: String, desc: 'new password'
      requires :password_confirmation, type: String, desc: 'new password confirmation'
    end
    post '/update_password' do
      user = Student.find_by_reset_password_token params[:reset_password_token]
      present not_found! unless user
      if params[:password] == params[:password_confirmation] && params[:password].length>=6 && user.reset_password!(params[:password])
        present success_message: 'your password updated successfully'
      else
        present unprocessable_entity!
      end
    end
  end
end
