class NewPageWorker
  include Sidekiq::Worker
  attr_reader :page

  def perform(page_id)
    @page = Page.find(page_id)
    process
  rescue SocketError, Gastly::FetchError, OpenURI::HTTPError, Net::OpenTimeout
    page.update_attributes(status: Page::ERROR_STATUS)
  end

  private

  def process
    page.update_attributes(status: Page::IN_PROGRESS_STATUS)
    parse_html_content
    make_screenshot
    page.update_attributes(status: Page::PROCESSED_STATUS)
  end

  def download_screenshot(file)
    File.new(Gastly.capture(page.source_url, file.path))
  end

  def make_screenshot
    file = Tempfile.new
    page.update_attributes(screenshot: download_screenshot(file))
  ensure
    file.close!
  end

  def download_content
    Nokogiri::HTML(open(page.source_url))
  end

  def parse_html_content
    doc_html = download_content
    if doc_html.content.present?
      title = doc_html.css('title').first.content
      doc = doc_html.css('body').first.content
      page.update_attributes(content_html: doc_html, content: doc, title: title)
    end
  end
end
