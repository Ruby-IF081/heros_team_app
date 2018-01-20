class Api::SessionsController < Api::BaseController
  skip_before_action :require_login!, only: [:create], raise: false

  def create
    parameters = params[:user_login]
    resource = User.find_for_database_authentication(email: parameters[:email])
    resource ||= User.new

    if resource.valid_password?(parameters[:password])
      auth_token = resource.generate_auth_token
      render json: { auth_token: auth_token }
    else
      invalid_login_attempt
    end
  end

  def destroy
    resource = current_person
    resource.invalidate_auth_token
    head :ok
  end

  private

  def invalid_login_attempt
    render json: { errors: [{ detail: "Error with your login or password" }] }, status: 401
  end
end
