class Account::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @chart_value = current_companies
    @count_of_pages = CompanyPagesAnalytics.count_pages(current_tenant)
    @recent_companies = current_companies.limit(10)
  end
end
