require 'rails_helper'

RSpec.describe CompanyDomainWorker, sidekiq: true do
  let!(:company) { create(:company, :worker_domain) }
  let!(:worker) { CompanyDomainWorker.new }

  before(:each) do
    allow(worker).to receive(:link_open).and_return(response_html)

    worker.perform(company.id)
  end

  describe 'with valid data' do
    let!(:response_html) { Nokogiri::HTML(open('spec/factories/test.html')) }

    it 'testing worker queueing' do
      expect { CompanyDomainWorker.perform_async(1) }.to change(CompanyDomainWorker.jobs, :size).by(1)
    end

    it 'worker company should be as created one' do
      expect(worker.company).to eq(company)
    end

    it 'sub_links content should be correct. not nil, empty, outside' do
      worker.send(:filtered_sub_pages_links).each do |link|
        expect(link).not_to be_nil
        expect(link).not_to be_empty
        expect(link).not_to be('#')

        expect(link).to include(worker.domain)
      end
    end

    it 'number of created pages should be as number of sub_links' do
      expect { worker.perform(company.id) }.to change(Page, :count).by(89)
    end
  end

  describe 'with invalid data' do
    let!(:response_html) do
      Nokogiri::HTML('<html><head><title>Hello World</title></head>
                      <body><a href="#"></a>
                            <a href=""></a>
                            <a href=></a>
                            <a href="http://youtube.com"></a></body></html>')
    end

    it 'empty sub_links array' do
      expect(worker.send(:filtered_sub_pages_links)).to be_empty
    end

    it 'number of created pages should be as number of sub_links' do
      # 1 because worker still creates page with company_domain
      # inserted by user while creating a company
      expect { worker.perform(company.id) }.to change(Page, :count).by(1)
    end
  end
end
