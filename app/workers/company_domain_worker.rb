class CompanyDomainWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  attr_reader :company, :domain

  def perform(company_id)
    @company = Company.find(company_id)
    @domain = @company.domain

    create_pending_page(domain)
    sub_pages_process
  end

  private

  def sub_pages_process
    filtered_sub_pages_links.each do |link|
      create_pending_page(link)
    end
  end

  def download_url(link)
    link = link.downcase
    link = 'http://' + link unless link.start_with?('http://', 'https://')
    Nokogiri::HTML(open(link))
  end

  def page_html_links
    content = download_url(domain)
    main_html = content.css('body')
    main_html.css('a').map { |href_link| href_link['href'] }
  end

  def filtered_sub_pages_links
    links = page_html_links.uniq.reject(&:blank?)
    sub_links = []
    links.each do |link|
      next if invalid_link?(link)
      link = page_url(link)
      sub_links.push(link)
    end
    sub_links
  end

  def invalid_link?(link)
    link == '#' || (link.include?('://') && link.exclude?(domain))
  end

  def page_url(link)
    link.exclude?('://') ? (domain + link) : link
  end

  def create_pending_page(source_url)
    source_url = 'http://' + source_url unless source_url.start_with?('http://', 'https://')
    company.pages.create(title: Page::PENDING_TITLE,
                         page_type: Page::OFFICIAL_PAGE,
                         source_url: source_url,
                         status: Page::PENDING_STATUS)
  end
end
