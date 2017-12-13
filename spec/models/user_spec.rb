require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_length_of(:first_name).is_at_least(3).is_at_most(50) }
    it { should validate_length_of(:last_name).is_at_least(3).is_at_most(50) }
    it { should validate_length_of(:email).is_at_most(255) }
    it { should validate_length_of(:password).is_at_least(6).is_at_most(25) }
    it { should define_enum_for(:role) }
  end
end
