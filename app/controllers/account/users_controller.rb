class Account::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admins!

  def index
    @search = collection.ransack(params[:q])
    @users = @search.result.page(params[:page]).per(10)
    @roles = select_role
  end

  def impersonate
    user = resource
    impersonate_user(user)
    redirect_to root_path
  end

  def stop_impersonating
    stop_impersonating_user
    redirect_to root_path
  end

  def show
    @user = resource
  end

  def new
    @user = User.new
    @roles = select_role
  end

  def create
    @user = User.new(resource_params)
    @user.assign_attributes(tenant: current_tenant, password: User::DEFAULT_PASSWORD)
    if @user.valid? && legal_role?
      @user.save
      UsersMailer.credentials(@user).deliver
      redirect_to account_users_path, flash: { success: 'New user is successfuly created!' }
    else
      flash[:danger] = 'Your new user has invalid data!'
      render :new
    end
  end

  def edit
    @user = resource
    @roles = select_role
  end

  def update
    @user = resource
    if @user.valid? && legal_role?
      @user.update_attributes(resource_params)
      redirect_to account_users_path, flash: { success: 'Successfuly updated!' }
    else
      flash[:danger] = 'Failed to update!'
      render :edit
    end
  end

  def destroy
    @user = resource
    @user.destroy
    redirect_to account_users_path, flash: { success: 'User deleted!' }
  end

  private

  def resource_params
    params.require(:user).permit(:first_name, :last_name, :email, :role)
  end

  def admin_collection
    current_tenant.users.by_date
  end

  def super_admin_collection
    User.all.by_date
  end

  def resource
    collection.find(params[:id])
  end

  def collection
    current_user.super_admin? ? super_admin_collection : admin_collection
  end

  def select_role
    current_user.admin? ? User::ROLES.reject { |role| role == User::SUPER_ADMIN_ROLE } : User::ROLES
  end

  def legal_role?
    select_role.include?(resource_params[:role])
  end
end
