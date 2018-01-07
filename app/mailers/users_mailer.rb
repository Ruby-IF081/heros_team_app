class UsersMailer < ApplicationMailer
  def credentials(user)
    @user = user
    mail to: user.email, subject: 'Your credentials'
  end
end
