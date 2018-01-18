require 'rails_helper'

RSpec.describe CompanyDomainWorker, sidekiq: true do
  let!(:company) { create(:company, :worker_domain) }
  let!(:worker) { CompanyDomainWorker.new }

  before(:each) do
    allow(worker).to receive(:download_url).and_return(response_html)
  end

  context 'with valid data' do
    let!(:response_fixture) { Rails.root.join('spec/fixtures/test.html').to_s }
    let!(:response_html) { Nokogiri::HTML(File.read(response_fixture)) }

    it 'worker company should be as created one' do
      worker.perform(company.id)
      expect(worker.company).to eq(company)
    end

    it 'sub_links content should be correct. should not be nil, empty or outside links' do
      worker.perform(company.id)
      worker.send(:filtered_sub_pages_links).each do |link|
        expect(link).not_to be_nil
        expect(link).not_to be_empty
        expect(link).not_to be('#')

        expect(link).to include(worker.domain)
      end
    end

    it 'number of created pages should be as number of sub_links' do
      expect do
        worker.perform(company.id)
      end.to change { Page.where(page_type: Page::OFFICIAL_PAGE).count }.by(89)
    end
  end

  context 'with invalid data' do
    let!(:response_html) do
      Nokogiri::HTML('<html><head><title>Hello World</title></head>
                      <body><a href="#"></a>
                            <a href=""></a>
                            <a href=></a>
                            <a href="http://youtube.com"></a></body></html>')
    end

    it 'empty sub_links array' do
      worker.perform(company.id)
      expect(worker.send(:filtered_sub_pages_links)).to be_empty
    end

    it 'number of created pages should be as number of sub_links' do
      # 1 because worker still creates page with company_domain
      # inserted by user while creating a company
      expect do
        worker.perform(company.id)
      end.to change { Page.where(page_type: Page::OFFICIAL_PAGE).count }.by(1)
    end
  end
end
