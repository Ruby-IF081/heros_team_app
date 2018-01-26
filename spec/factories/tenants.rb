# == Schema Information
#
# Table name: tenants
#
#  id         :integer          not null, primary key
#  name       :string
#  phone      :string
#  website    :string
#  logo       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :integer
#

FactoryBot.define do
  factory :tenant, class: Tenant do
    name { Faker::Company.name }
    phone { Faker::PhoneNumber.cell_phone }
    website { Faker::Internet.unique.domain_name }
    logo { Faker::Company.logo }
  end
end
