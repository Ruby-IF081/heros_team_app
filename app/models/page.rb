# == Schema Information
#
# Table name: pages
#
#  id           :integer          not null, primary key
#  page_type    :integer
#  title        :string
#  content_html :string
#  content      :string
#  source_url   :string
#  status       :integer
#  screenshot   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :integer
#

class Page < ApplicationRecord
  STATUSES = %i[active pending finished].freeze
  PAGE_TYPES = %i[bing angle.co linkedin crunchbase].freeze
  enum status: STATUSES
  enum page_type: PAGE_TYPES
end
