class Account::ProfileController < ApplicationController
  before_action :authenticate_user!

  def edit
    @profile = current_user
  end

  def update
    @profile = current_user
    if @profile.update_attributes(user_params)
      flash[:success] = "Profile updated!"
      redirect_to account_user_path(@profile)
    else
      flash[:danger] = 'Failed to update!'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :date_of_birth,
                                 :email, :phone, :work, :skils, :education, :about)
  end
end
