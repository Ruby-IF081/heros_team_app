# == Schema Information
#
# Table name: companies
#
#  id                :integer          not null, primary key
#  name              :string
#  domain            :string
#  youtube           :string
#  twitter           :string
#  linkedincompany   :string
#  facebook          :string
#  angellist         :string
#  owler             :string
#  crunchbasecompany :string
#  pinterest         :string
#  google            :string
#  klout             :string
#  overview          :string
#  founded           :integer
#  approx_employees  :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#  logo              :string
#

require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'validations with factories' do
    let!(:val_company) { build(:company) }
    let!(:inval_company) { build(:company, :invalid_domain) }

    it 'has a valid Factory' do
      expect(val_company).to be_valid
    end

    it 'has a invalid Factory' do
      expect(inval_company).not_to be_valid
    end
  end
end
