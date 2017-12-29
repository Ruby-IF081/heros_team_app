class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_tenant
    current_user&.tenant
  end

  def authorize_admin!
    redirect_to(root_path) unless current_user&.role == User::ADMIN_ROLE
  end
end
