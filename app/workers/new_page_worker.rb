class NewPageWorker
  include Sidekiq::Worker

  def perform(page_id)
    page = Page.find(page_id)
    page.update_attributes(status: Page::ACTIVE_STATUS)
    make_screenshot(page)
    parse_html_content(page)
    logger.info "Page #{page.id} processed!"
  end

  private

  def downloading_screenshot(file, source_url)
    Gastly.capture(source_url, file.path)
  end

  def make_screenshot(page)
    file = Tempfile.new
    page.update_attributes(screenshot: File.new(downloading_screenshot(file, page.source_url)))
    file.unlink
  end

  def downloading_content(source_url)
    Nokogiri::HTML(open(source_url))
  end

  def parse_html_content(page)
    doc_html = downloading_content(page.source_url)
    title = doc_html.css('title').first.content
    doc = doc_html.css('body').first.content
    page.update_attributes(content_html: doc_html, content: doc, title: title)
  end
end
