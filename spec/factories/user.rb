FactoryBot.define do
  sequence :email do |n|
    "#{n}#{Faker::Internet.email}"
  end
  factory :user, class: User do
    first_name { Faker::Name.unique.first_name }
    last_name { Faker::Name.unique.last_name }
    email { generate :email }
    password { Faker::Internet.password }
  end
end