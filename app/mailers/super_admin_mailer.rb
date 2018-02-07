class SuperAdminMailer < ApplicationMailer
  def daily_user_creation_notification
    @users = User.created_yesterday
    mail to: emails, subject: 'Users created on the previous day' if emails.any?
  end

  private

  def emails
    User.super_admins.pluck(:email)
  end
end
