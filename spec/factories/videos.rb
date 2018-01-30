# == Schema Information
#
# Table name: videos
#
#  id             :integer          not null, primary key
#  title          :string
#  embed_code     :text
#  videoable_id   :integer
#  videoable_type :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :video, class: Video do
    association :videoable, factory: :company
    title { Faker::Beer.name }
    embed_code do
      "<iframe src='https://www.youtube.com/embed/6oAqOFz6QsU" \
        "?rel=0' frameborder='0' allow='autoplay; encrypted-media' allowfullscreen></iframe>"
    end
  end
end
