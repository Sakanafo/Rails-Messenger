class Users < BaseApi
  resource :users do
    desc 'User login'
    params do
      requires :email, type: String
      requires :password, type: String
    end
    post :sign_in do
      user = User.find_by(email: params[:email])
      if user&.valid_password?(params[:password])
        token = user.generate_jwt
        header 'Authorization', " #{token} "
        { message: 'Login successful', user: user.as_json(only: %i[id email name]) }
      else
        error!('Invalid email or password', 401)
      end
    end
    desc 'User logout'
    delete :sign_out do
      authenticate!
      { message: 'Logged out successfully' }
    end
  end
end
