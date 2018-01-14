class Users::TrackSessionsController < Devise::SessionsController
  after_action :user_logins, only: [:create]

  def user_logins
    Visit.create(user_id: current_user.id, tenant_id: current_tenant.id)
  end
end
