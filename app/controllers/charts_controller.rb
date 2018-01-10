class ChartsController < ApplicationController
  include ApplicationHelper
  def new_users_by_week
    render json: three_month(User).group_by_week(:created_at).count
  end

  def new_companies_by_week
    render json: three_month(Company).group_by_week(:created_at).count
  end

  def new_users
    render json: User.group_by_month_of_year(:created_at).count
  end

  def new_companies
    render json: Company.group_by_day_of_week(:created_at).count
  end

  def users_login
    render json: Visit.group_by_week(:created_at).count
  end
end
