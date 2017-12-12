require 'rails_helper'

RSpec.describe Tenant, type: :model do

  it 'is valid with name, phone, website and logo' do
     tenant = Tenant.new(
       name:    'Heroes co.',
       phone:   '1-800-291-9249',
       website: 'heroes.com',
       logo:    ''
    )
    expect(tenant).to be_valid
  end

  # it { should have_many(:users).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:website) }
  it { should validate_uniqueness_of(:website).case_insensitive }

  it do
    should validate_length_of(:name).
      is_at_least(3).is_at_most(64)
  end

  it do
    should validate_length_of(:website).
      is_at_least(3).is_at_most(64)
  end
end
