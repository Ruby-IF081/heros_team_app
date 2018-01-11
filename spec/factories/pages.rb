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
#  company_id   :integer
#

FactoryBot.define do
  factory :page do
    company
    page_type { Page::PAGE_TYPES.sample }
    title { Faker::Beer.name }
    source_url { Faker::Internet.url('en.wikipedia.org/wiki') }
    status { Page::PENDING_STATUS }

    trait :with_content do
      content_html { Faker::Lorem.paragraphs(10).join }
      content { Faker::Lorem.paragraphs(10).join }
      screenshot { Faker::Avatar.image }
    end
  end
end
