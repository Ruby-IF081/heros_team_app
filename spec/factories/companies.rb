FactoryBot.define do
  factory :company, class: Company do
    user
    name { Faker::Company.name }
    domain { Faker::Internet.domain_name }
    created_at { rand(3.month.ago..Time.now) }

    trait :invalid_domain do
      domain { Faker::Internet.email }
    end
  end
end
