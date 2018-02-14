class CompanyOverview
  include Rails.application.routes.url_helpers
  include BasePresenterHelper

  def initialize(company)
    @company = company
  end

  def json_presenter
    {
      name: @company.name,
      overview: @company.overview,
      founded: @company.founded,
      approx_employees: @company.approx_employees,
      logo: @company.logo.thumb.url,
      url_domain: urlify(@company.domain),
      industries: @company.industries.reorder(:name).select(:id, :name),
      pages_path: account_company_pages_path(@company)
    }.as_json
  end
end
