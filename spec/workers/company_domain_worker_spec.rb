require 'rails_helper'

RSpec.describe CompanyDomainWorker, sidekiq: true do
  let!(:worker) { CompanyDomainWorker.new }

  it 'testing worker queueing' do
    expect { CompanyDomainWorker.perform_async(1) }.to change(CompanyDomainWorker.jobs, :size).by(1)
  end
end
