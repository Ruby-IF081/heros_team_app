class Api::BaseController < ActionController::Base
  before_action :require_login!

  def require_login!
    if find_user_by_token
      return true if current_person.authenticate_token_creation
      render json: { errors: [{ detail: 'Your key is expired' }] }, status: 401
    else
      render json: { errors: [{ detail: 'Access denied' }] }, status: 401
    end
  end

  def current_person
    @current_user ||= find_user_by_token
  end

  private

  def find_user_by_token
    authenticate_with_http_token do |token|
      User.find_by(auth_token: token)
    end
  end
end
