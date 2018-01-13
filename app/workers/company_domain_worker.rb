class CompanyDomainWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  attr_reader :company, :filt_links, :domain

  def perform(company_id)
    @company = Company.find(company_id)
    @domain = @company.domain

    page_create_pending(@domain)
    sub_pages_process
  end

  private

  def sub_pages_process
    @filt_links = filtered_sub_pages_links
    @filt_links.each do |link|
      page_create_pending(link)
    end
  end

  def link_open(link)
    link = 'http://' + link if link.exclude? '://'
    Nokogiri::HTML(open(link))
  end

  def page_html_links
    domain_index = link_open(@domain)
    main_html = domain_index.css('body')
    main_html.css('a').map { |href_link| href_link['href'] }
  end

  def filtered_sub_pages_links
    links = page_html_links
    links = links.uniq.reject { |page_link| page_link.to_s.empty? }
    sub_links = []
    links.each do |link|
      next if link == '#'
      next if link.include?('://') && link.exclude?(@domain)
      link = page_url(link)
      sub_links.push(link)
    end
    sub_links
  end

  def page_url(link)
    return (@domain + link) if link.exclude? '://'
    link
  end

  def page_create_pending(source_url)
    Page.create(title: Page::PENDING_TITLE,
                page_type: Page::OFFICIAL_PAGE,
                source_url: source_url,
                status: Page::PENDING_STATUS,
                company: @company)
  end
end
