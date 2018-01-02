class Account::TenantsController < ApplicationController
  before_action :authenticate_user!

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
end
