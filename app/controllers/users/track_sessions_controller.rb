class Users::TrackSessionsController < Devise::SessionsController
  after_action :after_login, :only => :create

  def after_login
    Visit.create!(user_id: current_user.id)
  end
end