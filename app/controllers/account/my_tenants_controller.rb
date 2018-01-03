class Account::MyTenantsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!, only: %i[edit update]

  def show
    @tenant = current_tenant
  end

  def edit
    @tenant = current_tenant
  end

  def update
    @tenant = current_tenant
    if @tenant.update(tenant_params)
      redirect_to account_my_tenant_path, flash: { success: "Information is updated" }
    else
      render :edit
    end
  end

  private

  def tenant_params
    params.require(:tenant).permit(:name, :website, :phone)
  end
end
