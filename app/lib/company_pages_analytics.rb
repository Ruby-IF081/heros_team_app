class CompanyPagesAnalytics
  def self.count_pages(current_tenant)
    current_tenant.pages.where(
      'page_type not in (?) and pages.created_at > ?',
      Page::MANUALLY_ADDED_PAGES_TYPES, 1.day.ago
    ).count
  end
end
