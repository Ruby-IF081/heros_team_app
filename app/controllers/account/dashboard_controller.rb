class Account::DashboardController < ApplicationController
  LIMIT_OF_RECENT_COMPANIES = 5

  before_action :authenticate_user!

  def index
    @chart_value = current_companies
    @count_of_pages = CompanyPagesAnalytics.count_pages(current_tenant)
    @recent_companies = current_companies.order(created_at: :desc).limit(10)
  end
end
