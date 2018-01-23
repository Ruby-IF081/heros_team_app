class TokensController < ApplicationController
  before_action :authenticate_user!

  def generate_token
    @user = current_user
    @user.generate_auth_token
    if @user.save
      flash[:success] = "Your new API key is #{@user.auth_token}"
    else
      flash[:danger] = "Something went wrong, please contact support"
    end
    redirect_to account_user_path(@user)
  end

  def deactivate_token
    @user = current_user
    @user.update(auth_token: nil, token_created_at: nil)
    redirect_to account_user_path(@user),
                flash: { info: "Your API key was successfully deactivated" }
  end
end
