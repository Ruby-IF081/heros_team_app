class Account::TenantsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tenants = Tenant.all.page(params[:page]).per(10)
  end

  def show
    @tenant = current_tenant
  end

  def new
    @tenant = Tenant.new
  end

  def create
    @tenant = Tenant.new(tenant_params)
    if @tenant.save
      flash[:success] = "Tenant is successfully created"
      redirect_to account_tenant_path(@tenant)
    else
      render :new
    end
  end

  def edit
    @tenant = current_tenant
  end

  def update
    @tenant = current_tenant
    if @tenant.update_attributes(tenant_params)
      flash[:success] = "Information is updated"
      redirect_to account_tenant_path(@tenant)
    else
      render :edit
    end
  end

  def destroy
    current_tenant.destroy
    flash[:success] = "Tenant is deleted"
    redirect_to account_tenants_path
  end

  private

  def tenant_params
    params.require(:tenant).permit(:name, :website, :phone)
  end

  def current_tenant
    Tenant.find(params[:id])
  end
end
