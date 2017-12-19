# == Schema Information
#
# Table name: pages
#
#  id           :integer          not null, primary key
#  page_type    :integer
#  title        :string
#  content_html :string
#  content      :string
#  source_url   :string
#  status       :integer
#  screenshot   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :integer
#

require 'rails_helper'

RSpec.describe Page, type: :page do
  context 'validation' do
    it { FactoryBot.build(:page).should be_valid }
  end
end
