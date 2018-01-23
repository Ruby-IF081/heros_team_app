class Api::BaseController < ActionController::Base
  before_action :require_login!
  helper_method :current_person

  def require_login!
    return true if authenticate_token
    if token_exists
      render json: { errors: [{ detail: 'Your key is expired' }] }, status: 401
    else
      render json: { errors: [{ detail: 'Access denied' }] }, status: 401
    end
  end

  def current_person
    @current_person ||= token_exists
  end

  def person_present
    current_person.present?
  end

  private

  def token_exists
    authenticate_with_http_token do |token|
      User.find_by(auth_token: token)
    end
  end

  def authenticate_token
    current_person.token_created_at >= 1.month.ago if person_present
  end
end
