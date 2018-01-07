require 'rails_helper'

RSpec.describe Account::DashboardController, type: :controller do
  before :each do
    @user = FactoryBot.create(:user, :admin)
    sign_in @user
  end
  describe "GET #index" do
    it "returns a 200 status code" do
      get :index
      expect(response).to have_http_status(200)
    end
  end
end
