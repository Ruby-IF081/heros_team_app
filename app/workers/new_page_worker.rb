class NewPageWorker
  include Sidekiq::Worker
  attr_reader :page, :doc_html

  def perform(page_id)
    @page = Page.find(page_id)
    process
  rescue IOError, Gastly::FetchError
    page.update_attributes(status: Page::ERROR_STATUS)
  end

  private

  def process
    page.update_attributes(status: Page::IN_PROGRESS_STATUS)
    @doc_html = download_content
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
    file = open(page.source_url)
    Nokogiri::HTML(file)
  rescue StandardError => msg
    page.update_attributes(response_status: msg.to_s)
    raise IOError
  end

  def parse_html_content
    if doc_html.content.present?
      title = doc_html.css('title').first.content
      doc = doc_html.css('body').first.content
      page.update_attributes(content_html: doc_html, content: doc, title: title)
    end
  end
end
