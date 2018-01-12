class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  impersonates :user

  layout :layout_by_resource

  def current_tenant
    current_user&.tenant
  end

  def authorize_admin!
    redirect_to(root_path) unless true_user&.admin?
  end

  def authorize_super_admin!
    redirect_to(root_path) unless true_user&.super_admin?
  end

  def layout_by_resource
    if %w[registrations sessions].include?(controller_name) && action_name == 'new'
      "landing"
    else
      "application"
    end
  end
end
