class UserOverview < ActionView::Base
  include Rails.application.routes.url_helpers
  include BasePresenterHelper
  include GravatarImageTag

  def initialize(user)
    @user = user
  end

  def json_presenter
    user_email = @user.email
    {
      avatar_url: gravatar_image_url(user_email, size: 150),
      full_name: @user.full_name,
      email: user_email,
      role: @user.role,
      created_at: @user.created_at.strftime('%F %r'),
      tenant_name: @user.tenant_name
    }.as_json
  end
end
