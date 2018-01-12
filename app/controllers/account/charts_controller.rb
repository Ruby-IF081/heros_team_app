class Account::ChartsController < ApplicationController
  before_action :authorize_admin!
  def users_by_week
    chart_data = current_tenant.users
    render json: chart_data.group_by_week(:created_at, range: time_range).count
  end

  def companies_by_week
    chart_data = current_tenant.companies
    render json: chart_data.group_by_week('companies.created_at', range: time_range).count
  end

  def users_by_month
    render json: current_tenant.users.group_by_month_of_year(:created_at).count
  end

  def users_logins
    users_list = Visit.where(tenant_id: current_tenant.id)
    render json: users_list.group_by_week(:created_at).count
  end

  def time_range
    3.month.ago..Time.current
  end
end
