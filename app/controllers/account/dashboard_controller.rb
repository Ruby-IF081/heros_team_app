class Account::DashboardController < ApplicationController
  before_action :authenticate_user!
  layout 'account'

  def index
    render locals: { chart_value: current_companies }
  end
end
