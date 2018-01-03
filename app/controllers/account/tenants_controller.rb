class Account::TenantsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_moderator

  def index
    @tenants = Tenant.all.page(params[:page]).per(10)
  end

  def show
    @tenant = current_tenant
  end

  private

  def current_tenant
    Tenant.find(params[:id])
  end

  def check_if_moderator
    render html: 'Access denied', status: 403 unless current_user.role == User::MODERATOR_ROLE
  end
end
