class FullContactCompanyProcessor
  def initialize(company:)
    @company = company
  end

  def process
    response = call_fullcontact_api
    return if not_valid_response?(response)
    process_links(response['social_profiles'])
    process_organization(response['organization'])
    process_industries(response['industries'])
    process_logo(response['logo'])
    @company.save
    @company
  end

  private

  def not_valid_response?(response)
    response.blank? || response['status'] != 200
  end

  def process_links(links_response)
    return unless links_response
    social_list = %w[twitter facebook linkedincompany youtube
                     angellist owler crunchbasecompany pinterest google klout]
    @company.attributes = find_url(social_list, links_response)
  end

  def process_organization(organization_response)
    return unless organization_response
    list = %w[name approx_employees founded overview]
    @company.attributes = organization_response.select { |key| list.include?(key) }
  end

  def process_logo(logo_response)
    return unless logo_response
    @company.remote_logo_url = logo_response
  end

  def call_fullcontact_api
    FullContact.company(domain: @company.domain).to_hash
  rescue FullContact::NotFound, FullContact::Invalid, FullContact::Forbidden
    nil
  end

  def process_industries(industries_response)
    return unless industries_response
    industries_response.each do |item|
      @company.industries << Industry.find_or_create_by(name: item['name'])
    end
  end

  def find_url(social, response)
    social.inject({}) do |acc, type_id|
      link = response.detect { |item| item['type_id'] == type_id }
      acc.tap { acc[type_id] = link['url'] if link }
    end
  end
end
