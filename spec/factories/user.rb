FactoryBot.define do
  factory :user, class: User do
    first_name { Faker::Name.unique.first_name }
    last_name { Faker::Name.unique.last_name }
    sequence(:email) { |n| "#{n}#{Faker::Internet.email}" }
    password { Faker::Internet.password }
  end
end
