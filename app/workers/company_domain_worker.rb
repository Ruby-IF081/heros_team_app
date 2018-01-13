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

  def link_open(link)
    link = 'http://' + link if link.exclude?('://')
    Nokogiri::HTML(open(link))
  end

  def page_html_links
    domain_index = link_open(domain)
    main_html = domain_index.css('body')
    main_html.css('a').map { |href_link| href_link['href'] }
  end

  def filtered_sub_pages_links
    links = page_html_links.uniq.reject { |page_link| page_link.to_s.empty? }
    sub_links = []
    links.each do |link|
      next if link == '#'
      next if link.include?('://') && link.exclude?(domain)
      link = page_url(link)
      sub_links.push(link)
    end
    sub_links
  end

  def page_url(link)
    return (domain + link) if link.exclude?('://')
    link
  end

  def create_pending_page(source_url)
    company.pages.create(title: Page::PENDING_TITLE,
                         page_type: Page::OFFICIAL_PAGE,
                         source_url: source_url,
                         status: Page::PENDING_STATUS)
  end
end
