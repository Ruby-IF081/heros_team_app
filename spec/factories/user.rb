FactoryBot.define do
  factory :user, class: User do
    first_name { Faker::Name.unique.first_name { 4..10 } }
    last_name { Faker::Name.unique.last_name { 4..10 } }
    sequence(:email) { |n| "#{n}#{Faker::Internet.email}" }
    tenant { build(:tenant) }
    password { Faker::Internet.password }

    trait :admin do
      role { User::ADMIN_ROLE }
    end

    trait :sale do
      role { User::SALE_ROLE }
    end

    trait :super_admin do
      role { User::SUPER_ADMIN_ROLE }
    end

    trait :old_random_date do
      created_at { rand(3.month.ago..Time.now) }
    end
  end
end
