require 'rails_helper'

RSpec.describe NewPageWorker, sidekiq: true do
  let!(:page) { create(:page) }
  let!(:worker) { NewPageWorker.new }
  let!(:content_response) do
    Nokogiri::HTML('<html><head><title>Hello World</title></head>
    <body><h1>Hello from body</h1></body></html>')
  end
  let!(:screenshot_response) { Tempfile.new }

  before(:each) do
    allow(worker).to receive(:download_content).and_return(content_response)
    allow(worker).to receive(:download_screenshot).and_return(screenshot_response)
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

  it 'page status should be error' do
    allow(worker).to receive(:download_content).and_raise(SocketError)
    worker.perform(page.id)
    page.reload

    expect(page.status).to eq('error')
  end
end
