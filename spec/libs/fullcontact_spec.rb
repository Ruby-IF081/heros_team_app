require 'rails_helper'
RSpec.describe FullContactCompanyProcessor do
  response = {
    "status" => 200,
    "organization" => { "name" => "Google" },
    "social_profiles" => [
      { "type_id" => "linkedincompany", "url" => "https://www.linkedin.com/company/google" }
    ],
    "industries" => [
      { "name" => "Advertising Agencies" },
      { "name" => "Computer Processing and Data Preparation and Processing Services" },
      { "name" => "Advertising Agencies" },
      { "name" => "Data Processing, Hosting, and Related Services" }
    ]
  }

  it "processes company with FullContact API data" do
    allow_any_instance_of(FullContactCompanyProcessor).to receive(:call_fullcontact_api)
      .and_return(response)
    company = create(:company)
    processor = FullContactCompanyProcessor.new(company: company)
    processor.process
    company.reload
    expect(company.name).to eq('Google')
    expect(company.linkedincompany).to eq('https://www.linkedin.com/company/google')
    expect(company.industries.size).to eq(3)
  end

  it "processes company with FullContact API data with empty hash" do
    allow_any_instance_of(FullContactCompanyProcessor).to receive(:call_fullcontact_api)
      .and_return({})
    company = create(:company)
    processor = FullContactCompanyProcessor.new(company: company)
    processor.process
    company.reload
    expect(company.linkedincompany).to eq(nil)
    expect(company.industries.size).to eq(0)
  end
end
