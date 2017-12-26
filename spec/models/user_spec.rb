require 'rails_helper'

describe User, type: :model do
  it { should belong_to(:tenant) }
  it { should have_many(:companies) }
  it { should accept_nested_attributes_for(:tenant) }
end
