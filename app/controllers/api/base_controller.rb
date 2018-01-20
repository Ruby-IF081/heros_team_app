class Api::BaseController < ActionController::Base
  before_action :require_login!
  helper_method :current_person

  def require_login!
    return true if authenticate_token
    render json: { errors: [{ detail: "Access denied" }] }, status: 401
  end

  def current_person
    @current_person ||= authenticate_token
  end

  private

  def authenticate_token
    authenticate_with_http_token do |token|
      User.where(auth_token: token).where("token_created_at >= ?", 1.month.ago).first
    end
  end
end
