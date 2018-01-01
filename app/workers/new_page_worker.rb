class NewPageWorker
  include Sidekiq::Worker

  def perform(page_id)
    page = Page.find(page_id)
    image = Gastly.capture('https://en.wikipedia.org/wiki/Special:Random',
                           "page_shot_#{page.id}.png")
    page.update_attributes(status: Page::ACTIVE_STATUS,
                           screenshot: File.new(File.join(image)))
    puts "Page #{page.id} created!"
  end
end
