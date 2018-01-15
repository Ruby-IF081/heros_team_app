class Account::ChartsController < ApplicationController
  before_action :authorize_admin!
  include ApplicationHelper
  def registered_users
    chart_data = current_tenant.users
    render json: chart_data.group_by_week(:created_at, range: time_range).count
  end

  def created_companies
    chart_data = current_tenant.companies
    render json: chart_data.group_by_week('companies.created_at', range: time_range).count
  end

  def registered_users_summary
    render json: current_tenant.users.group_by_month_of_year(:created_at).count
  end

  def users_logins
    users_list = current_tenant.visits
    render json: users_list.group_by_week(:created_at).count
  end
end
