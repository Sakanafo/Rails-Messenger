module UsersHelpers
  def authenticate!
    token = headers['Authorization'].split.last if headers['Authorization'].present?
    payload = JWT.decode(token, Rails.application.credentials.secret_key_base).first
    @current_user = User.find(payload['sub'])
  rescue JWT::DecodeError
    error!('Unauthorized', 401)
  end

  def current_user
    @current_user
  end
end
