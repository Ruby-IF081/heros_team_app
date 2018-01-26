# == Schema Information
#
# Table name: visits
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tenant_id  :integer
#

FactoryBot.define do
  factory :visit, class: Visit do
    user

    trait :old_random_date do
      created_at { rand(3.month.ago..Time.now) }
    end
  end
end
