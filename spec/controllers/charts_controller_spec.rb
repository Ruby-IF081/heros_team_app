require 'rails_helper'

RSpec.describe ChartsController, type: :controller do
  describe "GET requests to actions" do
    it "returns a 200 status code" do
      get :new_users_by_week
      expect(response).to have_http_status(200)
    end
    it "returns a 200 status code" do
      get :new_companies_by_week
      expect(response).to have_http_status(200)
    end
    it "returns a 200 status code" do
      get :new_users
      expect(response).to have_http_status(200)
    end
    it "returns a 200 status code" do
      get :new_companies
      expect(response).to have_http_status(200)
    end
    it "returns a 200 status code" do
      get :users_login
      expect(response).to have_http_status(200)
    end
  end
end
