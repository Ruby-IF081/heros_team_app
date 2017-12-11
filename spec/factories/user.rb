FactoryBot.define do
  factory :user, class: User do
    first_name { Faker::Name.last_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.safe_email }
    password { '1Qaz2Wsx' }
  end
end