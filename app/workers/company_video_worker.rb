class CompanyVideoWorker
  include Sidekiq::Worker

  def perform(company_id)
    company = Company.find(company_id)
    if company.youtube?
      channel = get_channel(company.youtube)
      channel_videos = get_videos(channel)
      channel_videos.each do |video|
        company.videos.create(title: video.title, embed_code: get_embed_code(video.id))
      end
    end
  end

  private

  def get_channel(channel_link)
    channel_id = channel_link.split('channel/').last
    authenticate(channel_id)
  end

  def get_videos(channel)
    channel.videos
  end

  def authenticate(id)
    Yt::Channel.new(id: id)
  end

  def get_embed_code(id)
    "<iframe src='https://www.youtube.com/embed/#{id}"\
      "?rel=0' frameborder='0' allow='autoplay; encrypted-media' allowfullscreen></iframe>"
  end
end
