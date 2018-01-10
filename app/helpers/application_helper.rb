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

  def select_range_for(entity, range)
    entity.where(created_at: range.month.ago..Time.current)
  end
end
