class NewPageWorker
  include Sidekiq::Worker

  def perform(page_id)
    page = Page.find(page_id)
    make_screenshot(page)
    parse_html_content(page)
    puts "Page #{page.id} created!"
  end

  private

  def make_screenshot(page)
    image_path_to_save = Rails.root.join('tmp', "page_shot_#{page.id}.png")
    image = Gastly.capture(page.source_url, image_path_to_save)
    page.update_attributes(status: Page::ACTIVE_STATUS, screenshot: File.new(File.join(image)))
    File.delete(image)
  end

  def parse_html_content(page)
    doc_html = Nokogiri::HTML(open(page.source_url))
    title = doc_html.css('title').first.content
    doc = ''
    doc_html.css('body').each do |tag|
      doc += '' + tag.content
    end
    page.update_attributes(content_html: doc_html, content: doc, title: title)
  end
end
