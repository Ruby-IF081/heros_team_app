require 'rails_helper'

RSpec.describe CompanyDomainWorker, sidekiq: true do
  let!(:company) { create(:company, :worker_domain) }
  let!(:worker) { CompanyDomainWorker.new }

  before(:each) do
    worker.perform(company.id)
  end

  it 'testing worker queueing' do
    expect { CompanyDomainWorker.perform_async(1) }.to change(CompanyDomainWorker.jobs, :size).by(1)
  end

  it 'worker company should be as created one' do
    expect(worker.company).to eq(company)
  end

  it 'sub_links content should be correct. not nil, empty, outside' do
    worker.filt_links.each do |link|
      expect(link).not_to be_nil
      expect(link).not_to be_empty
      expect(link).not_to be('#')

      expect(link).to include(worker.domain)
    end
  end

  it 'number of created pages should be as number of sub_links' do
    page_num = worker.filt_links.length + 1

    expect { worker.perform(company.id) }.to change(Page, :count).by(page_num)
  end
end
