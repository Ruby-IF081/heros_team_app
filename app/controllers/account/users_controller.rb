class Account::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index
    @users = collection.page(params[:page]).per(10)
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
  end

  def create
    @user = User.new(resource_params)
    @user.assign_attributes(tenant: current_tenant, password: User::DEFAULT_PASSWORD)
    if @user.save
      UsersMailer.credentials(@user).deliver
      redirect_to account_users_path, flash: { success: 'New user is successfuly created!' }
    else
      flash[:danger] = 'Your new user has invalid data!'
      render :new
    end
  end

  def edit
    @user = resource
  end

  def update
    @user = resource
    if @user.update_attributes(resource_params)
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

  def collection
    current_tenant.users.by_date
  end

  def resource
    collection.find(params[:id])
  end
end
