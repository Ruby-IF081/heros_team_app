class Account::TokensController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.generate_auth_token
    if current_user.save
      flash[:success] = "Your new API key is #{current_user.auth_token}"
    else
      flash[:danger] = "Something went wrong, please contact support"
    end
    redirect_to account_user_path(current_user)
  end

  def destroy
    current_user.deactivate_token
    redirect_to account_user_path(current_user),
                flash: { info: "Your API key was successfully deactivated" }
  end
end
