namespace :superadmin_user_creation_notifications do
  desc "Sends daily notifications to super_admins about users creations"
  task send: :environment do
    SuperAdminMailer.daily_user_creation_notification.deliver
  end
end
