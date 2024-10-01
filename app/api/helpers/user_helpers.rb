module UserHelpers
  def authenticate!
    error!('Unauthorized', 401) unless current_user
  end

  def current_user
    @current_user ||= authenticate_user_from_token
  end

  private

  def authenticate_user_from_token
    token = request.headers['Authorization']&.split(' ')&.last
    return nil unless token

    User.find_by_jwt(token)
  end
end
