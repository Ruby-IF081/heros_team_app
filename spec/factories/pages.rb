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

FactoryBot.define do
  factory :page do
    company
    page_type { Page::PAGE_TYPES.sample }
    title { Faker::Beer.name }
    content_html { Faker::Lorem.paragraphs(10).join }
    content { Faker::Lorem.paragraphs(10).join }
    source_url { Faker::Internet.url }
    status { Page::STATUSES.sample }
    screenshot { Faker::Avatar.image }
  end
end
