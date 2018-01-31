FactoryBot.define do
  factory :contact, class: Contact do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone }
    message { Faker::Lorem.paragraph(2, false, 5) }
  end
end
