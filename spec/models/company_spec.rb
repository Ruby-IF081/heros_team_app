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
    let!(:company) do
      build(:company, youtube: 'https://www.youtube.com/channel/UCVYd_qsRRTZFiRH8lPJoU3w')
    end
    let!(:id_response) { 'UCVYd_qsRRTZFiRH8lPJoU3w' }
    let!(:fake_videos_response) { [build(:page), build(:page)] }
    let!(:embed_code_response) do
      "<iframe src='https://www.youtube.com/embed/#{id_response}?rel=0'" \
        " frameborder='0' allow='autoplay; encrypted-media' allowfullscreen></iframe>"
    end

    it 'has a valid Factory' do
      expect(val_company).to be_valid
    end

    it 'has a invalid Factory' do
      expect(inval_company).not_to be_valid
    end

    it 'authenticate should return correct id' do
      id = company.send(:authenticate).id
      expect(id).to eq(id_response)
    end

    it 'embed code should be correct' do
      expect(company.send(:get_embed_code, id_response)).to eq(embed_code_response)
    end

    it 'create_video method should create one video' do
      allow(company).to receive(:get_videos).and_return(fake_videos_response)
      company.send(:create_video)
      expect(company.videos.size).to eq(2)
    end
  end
end
