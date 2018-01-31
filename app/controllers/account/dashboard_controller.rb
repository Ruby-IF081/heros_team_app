class Account::DashboardController < ApplicationController
  include CompanyPagesAnalyticsHelper

  before_action :authenticate_user!

  def index
    @chart_value = current_companies
    @count_of_pages = count_pages
  end
end
