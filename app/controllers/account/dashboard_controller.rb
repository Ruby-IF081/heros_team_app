class Account::DashboardController < ApplicationController
  before_action :authenticate_user!
  layout 'account'

  def index; end
end
