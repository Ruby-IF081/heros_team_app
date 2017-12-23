FactoryBot.define do
  factory :tenant, class: Tenant do
    name { Faker::Company.name }
    phone { Faker::PhoneNumber.cell_phone }
    website { Faker::Internet.unique.domain_name }
    logo { Faker::Company.logo }
  end
end
