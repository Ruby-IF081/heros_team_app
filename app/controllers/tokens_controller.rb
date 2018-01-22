class TokensController < ApplicationController
  before_action :authenticate_user!

  def generate_token
    @user = current_user
    token = SecureRandom.urlsafe_base64(25)
    @user.update_columns(auth_token: token, token_created_at: Time.zone.now)
    redirect_to account_user_path(@user), flash: { success: "Your new API key is #{token}" }
  end

  def deactivate_token
    @user = current_user
    @user.update_columns(auth_token: nil, token_created_at: nil)
    redirect_to account_user_path(@user),
                flash: { info: "Your API key was successfully deactivated" }
  end
end
