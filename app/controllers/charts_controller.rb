class ChartsController < ApplicationController
  def new_users_by_week
    render json: last_three_month_query(User).group_by_week(:created_at).count
  end
  def new_companies_by_week
    render json: last_three_month_query(Company).group_by_week(:created_at).count
  end
  def new_users
    render json: User.group_by_month_of_year(:created_at).count
  end
  def new_companies
    render json: Company.group_by_day_of_week(:created_at).count
  end
  
  def last_three_month_query(value)
    value.where(created_at: 3.month.ago..Time.current)
  end
end