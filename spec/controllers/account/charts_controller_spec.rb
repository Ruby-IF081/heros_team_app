require 'rails_helper'

RSpec.describe Account::ChartsController, type: :controller do
  before :each do
    @user = FactoryBot.create(:user, :admin)
    sign_in @user
  end

  it "returns a 200 status code with json response" do
    get :registered_users
    expect(response).to have_http_status(200)
    expect(response.content_type).to eq "application/json"
  end

  it "returns a 200 status code with json response" do
    get :created_companies
    expect(response).to have_http_status(200)
    expect(response.content_type).to eq "application/json"
  end

  it "returns a 200 status code with json response" do
    get :registered_users_summary
    expect(response).to have_http_status(200)
    expect(response.content_type).to eq "application/json"
  end

  it "returns a 200 status code with json response" do
    get :users_logins
    expect(response).to have_http_status(200)
    expect(response.content_type).to eq "application/json"
  end
end
