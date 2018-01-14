class Account::ChartsController < ApplicationController
  before_action :authorize_admin!
  def chart_for_user_registration
    chart_data = current_tenant.users
    render json: chart_data.group_by_week(:created_at, range: time_range).count
  end

  def chart_for_companies
    chart_data = current_tenant.companies
    render json: chart_data.group_by_week('companies.created_at', range: time_range).count
  end

  def chart_for_user_registraion_summary
    render json: current_tenant.users.group_by_month_of_year(:created_at).count
  end

  def chart_for_users_logins
    users_list = current_tenant.visits
    render json: users_list.group_by_week(:created_at).count
  end

  def time_range
    3.month.ago..Time.current
  end
end
