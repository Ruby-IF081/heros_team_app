require 'rubygems'
require 'nokogiri'
require 'open-uri'

class CompanyDomainProcessor
  def initialize(company)
    @company = company
    @domain = company.domain
    @domain = 'https://' + @domain unless @domain.include? '://'
  end

  def process
    if page_link_live(@domain)
      page_create_pending('Official page', @domain)
      sub_pages_process
    end
  end

  private

  def page_link_live(link)
    open(link)              # OpenSSL::SSL::SSLError: SSL_connect returned=1 errno=0
    true                    # state=error: certificate verify failed
  rescue => error           # OpenURI::HTTPError
    false
  end

  def sub_pages_process
    sub_links = filtered_sub_pages_links
    sub_links.each do |link|
      link = page_url(link)
      page_create_pending(page_title(link), page_url(link)) if page_link_live(link)
    end
  end

  def page_html_links(link)
    domain_index = Nokogiri::HTML(open(link))
    main_html = domain_index.css('body')
    main_html.css('a').map { |link| link['href'] }
  end

  def filtered_sub_pages_links
    links = page_html_links(@domain)
    links = links.uniq.reject { |e| e.to_s.empty? }
    sub_links = []
    links.each do |link|
      sub_links.push(link) unless link == '#' || (link.include?('://') && link.exclude?(@domain))
    end
    sub_links
  end

  def page_title(link)
    link = link.sub(@domain, '')
    'Official page' + link.tr('/', '.')
  end

  def page_url(link)
    return (@domain + link) unless link.include? '://'
    link
  end

  def page_create_pending(title, source_url)
    page = Page.new
    page.title = title
    page.company = @company
    page.source_url = source_url
    page.page_type = Page::OFFICIAL_PAGE
    page.status = Page::PENDING_STATUS
    page.save
  end
end
