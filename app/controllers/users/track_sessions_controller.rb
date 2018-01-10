class Users::TrackSessionsController < Devise::SessionsController
  after_action :user_logins, only: [:create]

  def user_logins
    current_user.visits.create
  end
end
