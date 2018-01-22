class Api::ResponsesController < Api::BaseController
  before_action :require_login!

  # This is protected by API token
  def companies
    @companies = current_person.companies
  end
end
