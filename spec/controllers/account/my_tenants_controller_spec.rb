require 'rails_helper'

RSpec.describe Account::MyTenantsController, type: :controller do
  before :each do
    @user = create(:user, :admin)
    sign_in @user
  end
  let!(:tenant) { FactoryBot.create(:tenant) }

  it 'GET #show' do
    get :show
    expect(response).to have_http_status(200)
  end

  it 'GET #edit' do
    get :edit
    expect(response).to have_http_status(200)
  end
end
