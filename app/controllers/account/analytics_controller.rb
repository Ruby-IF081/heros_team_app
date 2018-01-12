class Account::AnalyticsController < ApplicationController
  before_action :authorize_admin!
  layout 'account'

  def index; end
end
