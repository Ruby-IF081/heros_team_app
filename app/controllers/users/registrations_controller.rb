class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def new
    build_resource
    resource.build_tenant
    respond_with resource
  end

  def create
    super
    resource.update_attributes(role: User::ADMIN_ROLE)
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:first_name, :last_name, :email,
                                             :password, :password_confirmation,
                                             tenant_attributes: [:name]])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name email
                                                                password password_confirmation
                                                                current_password])
  end
end
