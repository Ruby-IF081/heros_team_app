class SuperAdminMailer < ApplicationMailer
  before_action :prevent_delivery_if_no_superadmins

  def daily_user_creation_notification
    @users = User.created_yesterday
    mail to: emails, subject: 'Users created on the previous day'
  end

  private

  def prevent_delivery_if_no_superadmins
    mail.perform_deliveries = false if emails.blank?
  end

  def emails
    User.super_admins.pluck(:email)
  end
end
