class Account::TokensController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = current_user
    @user.generate_auth_token
    if current_user.save
      respond_to_format
    else
      respond_to_format { render(js: "alert('Something went wrong, please contact support');") }
    end
  end

  def destroy
    current_user.deactivate_token
    respond_to_format
  end

  private

  def respond_to_format(block = nil)
    respond_to { |format| format.js { block } }
  end
end
