class Account::ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = current_user
  end

  def edit
    @profile = current_user
  end

  def update
    @profile = current_user
    if @profile.update(user_params)
      flash[:success] = "Profile updated!"
      redirect_to account_profile_path
    else
      flash[:danger] = 'Failed to update!'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :birthday,
                                 :email, :phone, :work, :skills, :education, :about)
  end
end
