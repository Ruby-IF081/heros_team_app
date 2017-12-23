require 'rails_helper'

RSpec.describe Tenant, type: :model do
  it 'has a valid factory' do
    expect(build(:tenant)).to be_valid
  end
end
