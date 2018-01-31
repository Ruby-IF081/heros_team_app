module CompanyPagesAnalyticsHelper
  def count_pages
    Page.where(
      'created_at > ? and page_type != ? and company_id = ?',
      1.day.ago, Page::CHROME_EXTENSION, current_companies.pluck(:id)
    ).count
  end
end
