class Api::CompaniesController < Api::BaseController
  # This is protected by API token
  def index
    @companies = current_person.companies
  end
end
