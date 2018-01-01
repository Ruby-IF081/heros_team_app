class NewCompanyWorker
  include Sidekiq::Worker

  def perform(company_id)
    company = Company.find(company_id)
    puts "Company #{company.id} created!"
    Page.create(page_type: Page::PAGE_TYPES.sample,
                title: Faker::Beer.name,
                content_html: Faker::Lorem.paragraphs(10).join,
                content: Faker::Lorem.paragraphs(10).join,
                source_url: Faker::Internet.url,
                status: Page::PENDING_STATUS,
                company: company)
  end
end
