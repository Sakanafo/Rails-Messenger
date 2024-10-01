class Users < BaseApi
  # helpers PaginationHelpers

  rescue_from :all do |e|
    error!({ error: e.message, backtrace: e.backtrace }, 500)
  end
  # resource :auth do
  #   desc 'Authenticate user'
  #   params do
  #     requires :email, type: String
  #     requires :password, type: String
  #   end
  #   post 'login' do
  #     user = User.find_for_database_authentication(email: params[:email])
  #     if user&.valid_password?(params[:password])
  #       { token: user.authentication_token }
  #     else
  #       error!('Unauthorized', 401)
  #     end
  #   end
  # end

  resource :users do
    params do
      optional :page, type: Integer, default: 1
      optional :per_page, type: Integer, default: 10
    end
    get do
      users = User.all
      data = paginate(users)
      # present data[:items], with: Entities::UserEntity
      present data[:pagination], with: Entities::PaginationEntity
    end
  end
end
