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

  def time_range
    3.month.ago..Time.current
  end

  def impersonated?
    current_user != true_user
  end

  def timeago(time)
    content_tag(:span, time.in_time_zone('Kyiv').strftime("%m/%d/%Y at %R"))
  end
end
