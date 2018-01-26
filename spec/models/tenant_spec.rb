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

require 'rails_helper'

RSpec.describe Tenant, type: :model do
  it 'has a valid factory' do
    expect(build(:tenant)).to be_valid
  end
end
