class Account::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @chart_value = current_companies
    @count_of_pages = todays_pages
  end

  private

  def todays_pages
    count = 0
    current_companies.each do |company|
      count += company.pages
                      .where('created_at > ?', 1.day.ago)
                      .where.not(page_type: Page::CHROME_EXTENSION).count
    end
    count
  end
end
