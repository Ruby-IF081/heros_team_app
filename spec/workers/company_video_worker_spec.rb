require 'rails_helper'

RSpec.describe CompanyVideoWorker, sidekiq: true do
  let!(:company) do
    create(:company, youtube: 'https://www.youtube.com/channel/UCVYd_qsRRTZFiRH8lPJoU3w')
  end
  let!(:worker) { CompanyVideoWorker.new }
  let!(:id_response) { 'UCVYd_qsRRTZFiRH8lPJoU3w' }
  let!(:fake_videos_response) { [build(:page), build(:page)] }
  let!(:embed_code_response) do
    "<iframe src='https://www.youtube.com/embed/#{id_response}?rel=0'" \
        " frameborder='0' allow='autoplay; encrypted-media' allowfullscreen></iframe>"
  end

  it 'testing worker queueing' do
    expect { CompanyVideoWorker.perform_async(1) }.to change(CompanyVideoWorker.jobs, :size).by(1)
  end

  it 'authenticate should return correct channel id' do
    channel_id = worker.send(:authenticate, id_response).id
    expect(channel_id).to eq(id_response)
  end

  it 'embed code should be correct' do
    expect(worker.send(:get_embed_code, id_response)).to eq(embed_code_response)
  end

  it 'create_video method should create two videos' do
    allow(worker).to receive(:get_videos).and_return(fake_videos_response)
    worker.perform(company.id)

    expect(company.videos.size).to eq(2)
  end
end
