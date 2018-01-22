require 'rails_helper'

RSpec.describe NewCompanyWorker, sidekiq: true do
  it 'testing worker queueing' do
    expect { NewCompanyWorker.perform_async(1) }.to change(NewCompanyWorker.jobs, :size).by(1)
  end
end
