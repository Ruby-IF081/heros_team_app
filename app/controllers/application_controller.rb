class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  impersonates :user
  helper_method :available_roles

  layout :layout_by_resource

  def current_tenant
    current_user&.tenant
  end

  def current_companies
    current_tenant&.companies
  end

  def authorize_admin!
    redirect_to(root_path) unless true_user&.admin?
  end

  def authorize_super_admin!
    redirect_to(root_path) unless true_user&.super_admin?
  end

  def authorize_admins!
    redirect_to(root_path) unless true_user&.privileged?
  end

  def layout_by_resource
    if devise_controller?
      "landing"
    else
      "application"
    end
  end

  def available_roles
    current_user.admin? ? User::ROLES.reject { |el| el.eql?(User::SUPER_ADMIN_ROLE) } : User::ROLES
  end
end
