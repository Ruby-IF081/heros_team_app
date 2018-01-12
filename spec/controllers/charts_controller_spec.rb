require 'rails_helper'

RSpec.describe Account::ChartsController, type: :controller do
  describe "GET requests to actions" do
    it "returns a 200 status code" do
      get :users_by_week
      expect(response).to have_http_status(302)
    end
    it "returns a 200 status code" do
      get :companies_by_week
      expect(response).to have_http_status(302)
    end
    it "returns a 200 status code" do
      get :users_by_month
      expect(response).to have_http_status(302)
    end
    it "returns a 200 status code" do
      get :users_logins
      expect(response).to have_http_status(302)
    end
  end
end
