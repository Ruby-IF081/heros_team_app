class SuperAdminMailer < ApplicationMailer
  default to: proc { User.super_admins.pluck(:email) }

  def daily_user_creation_notification
    @users = User.created_yesterday
    mail subject: 'Users created on the previous day'
  end
end
