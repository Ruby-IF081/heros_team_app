FactoryBot.define do
  factory :company, class: Company do
    user
    name { Faker::Company.name }
    domain { Faker::Internet.domain_name }

    trait :invalid_domain do
      domain { Faker::Internet.email }
    end

    trait :worker_domain do
      domain { 'softserve.ua' }
    end

    trait :old_random_date do
      created_at { rand(3.month.ago..Time.now) }
    end
  end
end
