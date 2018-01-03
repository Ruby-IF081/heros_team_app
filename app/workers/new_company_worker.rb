class NewCompanyWorker
  include Sidekiq::Worker

  def perform(company_id)
    company = Company.find(company_id)
    puts "Company #{company.id} created!"
    Page.create(page_type: Page::PAGE_TYPES.sample,
                source_url: Faker::Internet.url('en.wikipedia.org/wiki'),
                status: Page::PENDING_STATUS,
                company: company)
  end
end
