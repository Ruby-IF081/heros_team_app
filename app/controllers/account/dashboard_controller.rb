class Account::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @chart_value = current_companies
  end
end
