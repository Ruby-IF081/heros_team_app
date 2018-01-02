class Account::MyTenantsController < ApplicationController
  before_action :authenticate_user!

  def show
    @tenant = current_user.tenant
  end

  def edit
    @tenant = current_user.tenant
  end

  def update
    @tenant = current_user.tenant
    if @tenant.update(tenant_params)
      flash[:success] = "Information is updated"
      redirect_to account_my_tenant_path
    else
      render :edit
    end
  end

  private

  def tenant_params
    params.require(:tenant).permit(:name, :website, :phone)
  end
end
