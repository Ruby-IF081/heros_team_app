class Account::DashboardController < ApplicationController
  LIMIT_TO_SHOW = 5

  before_action :authenticate_user!

  def index
    @chart_value = current_companies
    @count_of_pages = CompanyPagesAnalytics.count_pages(current_tenant)
    @recent_companies = current_companies.recent.limit(LIMIT_TO_SHOW)
    @recent_pages = current_tenant.pages.recent.limit(LIMIT_TO_SHOW)
  end
end
