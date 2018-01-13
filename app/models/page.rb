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
#  rating       :integer          default 0
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Page < ApplicationRecord
  IN_PROGRESS_STATUS = 'in progress'.freeze
  PENDING_STATUS     = 'pending'.freeze
  PROCESSED_STATUS   = 'processed'.freeze
  ERROR_STATUS       = 'error'.freeze
  STATUSES           = [IN_PROGRESS_STATUS, PENDING_STATUS, PROCESSED_STATUS, ERROR_STATUS].freeze

  BING_TYPE        = 'bing'.freeze
  ANGLECO_TYPE     = 'angle.co'.freeze
  LINKEDIN_TYPE    = 'linkedin'.freeze
  CRUNCHBASE_TYPE  = 'crunchbase'.freeze
  CHROME_EXTENSION = 'chrome_extension'.freeze
  OFFICIAL_PAGE    = 'official_page'.freeze
  PAGE_TYPES       = [BING_TYPE,
                      ANGLECO_TYPE,
                      LINKEDIN_TYPE,
                      CRUNCHBASE_TYPE,
                      CHROME_EXTENSION,
                      OFFICIAL_PAGE].freeze

  LEGAL_RATING     = %w[1000 100 50 10 -10 -50 -100 -1000].freeze

  PENDING_TITLE    = 'pending'.freeze

  belongs_to :company

  mount_uploader :screenshot, ScreenshotUploader

  after_commit :start_worker, on: :create

  validates :title, presence: { message: 'Title cannot be empty' }, allow_blank: false
  validates :source_url, presence: { message: 'Source URL cannot be empty' }, allow_blank: false
  validates :company_id, presence: { message: 'Company must be selected' }

  scope :by_rating, -> { order(rating: :desc) }

  delegate :name, :id, to: :company, prefix: true, allow_nil: true

  def self.new_by_company(params, company)
    page = new(params)
    page.company = company
    page.page_type = Page::CHROME_EXTENSION
    page.status = Page::PENDING_STATUS
    page
  end

  def update_rating(new_rating)
    update(rating: new_rating.to_i + rating) if LEGAL_RATING.include?(new_rating)
  end

  private

  def start_worker
    NewPageWorker.perform_async(id)
  end
end
