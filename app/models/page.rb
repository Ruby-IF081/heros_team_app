# == Schema Information
#
# Table name: pages
#
#  id           :integer          not null, primary key
#  page_type    :string
#  title        :string
#  content_html :string
#  content      :string
#  source_url   :string
#  status       :string
#  screenshot   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Page < ApplicationRecord
  ACTIVE_STATUS = 'active'.freeze
  PENDING_STATUS = 'pending'.freeze
  FINISHED_STATUS = 'finished'.freeze
  STATUSES = [ACTIVE_STATUS, PENDING_STATUS, FINISHED_STATUS].freeze

  BING_TYPE = 'bing'.freeze
  ANGLECO_TYPE = 'angle.co'.freeze
  LINKEDIN_TYPE = 'linkedin'.freeze
  CRUNCHBASE_TYPE = 'crunchbase'.freeze
  CHROME_EXTENSION = 'chrome_extension'.freeze
  PAGE_TYPES = [BING_TYPE, ANGLECO_TYPE, LINKEDIN_TYPE, CRUNCHBASE_TYPE, CHROME_EXTENSION].freeze

  belongs_to :company

  validates :title, presence: { message: 'Title cannot be empty' }, allow_blank: false
  validates :source_url, presence: { message: 'Source URL cannot be empty' }, allow_blank: false
  validates :company_id, presence: { message: 'Company must be selected' }

  def self.new_by_company(params, company)
    page = new(params)
    page.company = company
    page.page_type = Page::CHROME_EXTENSION
    page.status = Page::PENDING_STATUS
    page
  end
end
