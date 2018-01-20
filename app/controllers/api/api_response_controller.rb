class Api::ApiResponseController < Api::BaseController
  before_action :require_login!

  # This is protected by API token
  def index
    render json: { companies: response_array }
  end

  private

  def response_array
    companies_array = []
    url_start = request.base_url
    current_person.companies.each do |company|
      company_hash = { "id": company.id,
                       "name": company.name,
                       "report_pdf_url": url_start + download_account_company_path(company,
                                                                                   format: 'pdf') }
      companies_array.push(company_hash)
    end
    companies_array
  end
end
