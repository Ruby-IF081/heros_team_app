# == Schema Information
#
# Table name: pages
#
#  id           :integer          not null, primary key
#  page_type    :string
#  title        :string
#  content_html :string
#  content      :string
#  source_url   :string
#  status       :string
#  screenshot   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Page, type: :page do
  context 'validation' do
    it { FactoryBot.build(:page).should be_valid }
  end
end
