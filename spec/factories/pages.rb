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

FactoryBot.define do
  factory :page do
    page_type { %i[bing angle.co linkedin crunchbase].sample }
    title { Faker::Beer.name }
    content_html { Faker::Lorem.paragraphs(10).join }
    content { Faker::Lorem.paragraphs(10).join }
    source_url { Faker::Internet.url }
    status { %i[active pending finished].sample }
    screenshot { Faker::Avatar.image }
  end
end
