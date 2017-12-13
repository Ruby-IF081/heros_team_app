FactoryBot.define do
  factory :user, class: User do
    sequence(:email) { |n| "#{n}#{Faker::Internet.email}" }
    first_name { Faker::Name.unique.first_name }
    last_name { Faker::Name.unique.last_name }
    email { generate :email }
    password { Faker::Internet.password }
  end
end
