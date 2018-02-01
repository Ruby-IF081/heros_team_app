class CompanyPagesAnalytics
  def self.count_pages(current_tenant)
    current_tenant.pages.where(
      'page_type != ? and pages.created_at > ?',
      Page::CHROME_EXTENSION, 1.day.ago
    ).count
  end
end
