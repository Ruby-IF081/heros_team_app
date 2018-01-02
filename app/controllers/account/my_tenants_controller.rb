class Account::MyTenantsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_admin, only: %i[edit update]
  before_action :current_tenant

  def show; end

  def edit; end

  def update
    if @tenant.update(tenant_params)
      flash[:success] = "Information is updated"
      redirect_to account_my_tenant_path
    else
      render :edit
    end
  end

  private

  def current_tenant
    @tenant = current_user.tenant
  end

  def tenant_params
    params.require(:tenant).permit(:name, :website, :phone)
  end

  def check_if_admin
    render html: "Access denied", status: 403 unless current_user&.role == User::ADMIN_ROLE
  end
end
