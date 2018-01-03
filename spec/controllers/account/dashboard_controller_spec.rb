require 'rails_helper'

RSpec.describe Account::DashboardController, type: :controller do
  describe "GET #index" do
    it "renders the :index view" do
      get :index
      expect(response).not_to have_http_status(200)
      expect(response).to have_http_status(302)
    end
  end
end
