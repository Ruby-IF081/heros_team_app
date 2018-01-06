class NewPageWorker
  include Sidekiq::Worker
  attr_reader :page, :doc_html

  def perform(page_id)
    @page = Page.find(page_id)
    @doc_html = downloading_content
  rescue SocketError, Gastly::FetchError, OpenURI::HTTPError, Net::OpenTimeout => error
    page.update_attributes(status: Page::ERROR_STATUS)
    logger.warn error
  end

  private

  def processing
    page.update_attributes(status: Page::IN_PROGRESS_STATUS)
    parse_html_content
    make_screenshot
    page.update_attributes(status: Page::PROCESSED_STATUS)
  end

  def downloading_screenshot(file)
    Gastly.capture(page.source_url, file.path)
  end

  def make_screenshot
    file = Tempfile.new
    page.update_attributes(screenshot: File.new(downloading_screenshot(file)))
    file.unlink
  end

  def downloading_content
    file = open(page.source_url)
    Nokogiri::HTML(file)
  end

  def parse_html_content
    unless doc_html.content == ''
      title = doc_html.css('title').first.content
      doc = doc_html.css('body').first.content
      page.update_attributes(content_html: doc_html, content: doc, title: title)
    end
  end
end
