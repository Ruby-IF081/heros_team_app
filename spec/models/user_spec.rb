# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  role                   :string           default("sale")
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  tenant_id              :integer
#  auth_token             :string
#  token_created_at       :datetime
#

require 'rails_helper'

describe User, type: :model do
  let!(:user) { build(:user, :sale, first_name: 'Winston', last_name: 'Churchill') }

  it { should belong_to(:tenant) }
  it { should have_many(:companies) }
  it { should accept_nested_attributes_for(:tenant) }

  it 'user full name should be correct' do
    expect(user.full_name).to eq('Winston Churchill')
  end

  it "privileged? method should be correct" do
    expect(user.privileged?).to be false
    user.role = User::ADMIN_ROLE
    expect(user.privileged?).to be true
  end
end
