class Account::AnalyticsController < ApplicationController
  before_action :authenticate_user!
  layout 'account'

  def index
    redirect_to root_path unless current_user.admin?
  end
end
