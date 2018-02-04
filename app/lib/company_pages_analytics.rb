class CompanyPagesAnalytics
  MANUALLY_ADDED_PAGES_TYPES = [Page::CHROME_EXTENSION, Page::BY_AJAX].freeze
  def self.count_pages(current_tenant)
    current_tenant.pages.where(
      'page_type not in (?) and pages.created_at > ?',
      MANUALLY_ADDED_PAGES_TYPES, 1.day.ago
    ).count
  end
end
