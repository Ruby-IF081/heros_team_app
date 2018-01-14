FactoryBot.define do
  factory :visit, class: Visit do
    user

    trait :old_random_date do
      created_at { rand(3.month.ago..Time.now) }
    end
  end
end
