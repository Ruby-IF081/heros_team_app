FactoryBot.define do
  factory :user, class: User do
    first_name { Faker::Name.unique.first_name }
    last_name { Faker::Name.unique.last_name }
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
  end
end
