# Preview all emails at http://localhost:3000/rails/mailers/super_admin_mailer
class SuperAdminMailerPreview < ActionMailer::Preview
  # Preview this email at
  # http://localhost:3000/rails/mailers/super_admin_mailer/daily_user_creation_notification
  def daily_user_creation_notification
    SuperAdminMailer.daily_user_creation_notification
  end
end
