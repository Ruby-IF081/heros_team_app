require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe NewPageWorker do
  let!(:page) { create(:page_without_content) }
  let!(:worker) { NewPageWorker.new }

  content_response = Nokogiri::HTML('<html><head><title>Hello World</title></head>
    <body><h1>Hello from body</h1></body></html>')

  before(:each) do
    allow_any_instance_of(NewPageWorker).to receive(:download_content).and_return(content_response)
    allow_any_instance_of(NewPageWorker).to receive(:download_screenshot)
      .and_return(Tempfile.new)
  end

  it 'testing worker queueing' do
    expect { NewPageWorker.perform_async(1) }.to change(NewPageWorker.jobs, :size).by(1)
  end

  it 'page title should be correct' do
    worker.perform(page.id)
    page.reload

    expect(page.title).to eq('Hello World')
  end

  it 'page content should be correct' do
    worker.perform(page.id)
    page.reload

    expect(page.content).to eq('Hello from body')
  end

  it 'page status should be processes' do
    worker.perform(page.id)
    page.reload

    expect(page.status).to eq('processed')
  end
end
