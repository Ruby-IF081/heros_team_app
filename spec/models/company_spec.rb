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
