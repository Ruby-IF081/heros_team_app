require 'rails_helper'

describe 'factory bot' do
  FactoryBot.factories.map(&:name).each do |factory_name|
    describe "#{factory_name} factory" do
      it { expect(build(factory_name)).to be_valid }
    end
  end
end
