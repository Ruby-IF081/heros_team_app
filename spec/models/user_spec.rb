require 'rails_helper'

describe User, type: :model do
  let!(:user) { build(:user, :sale, first_name: 'Winston', last_name: 'Churchill') }

  it { should belong_to(:tenant) }
  it { should have_many(:companies) }
  it { should accept_nested_attributes_for(:tenant) }

  it 'user full name should be correct' do
    expect(user.full_name).to eq('Winston Churchill')
  end
end
