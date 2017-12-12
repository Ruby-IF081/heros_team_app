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
end
