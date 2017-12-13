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
#  status       :integer
#  screenshot   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryBot.define do
  factory :page do
    page_type { 'bing' }
    title { Faker::Beer.name }
    content_html { Faker::Lorem.paragraphs(10) }
    content { Faker::Lorem.paragraphs(10) }
    source_url { Faker::Internet.url }
    status { %i[active pending finished].sample }
    screenshot { Faker::Avatar.image }
  end
end
