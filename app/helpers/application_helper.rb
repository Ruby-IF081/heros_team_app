module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def three_month(user)
    user.where(created_at: 3.month.ago..Time.current)
  end
end
