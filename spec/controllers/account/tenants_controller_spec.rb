require 'rails_helper'

RSpec.describe Account::TenantsController, type: :controller do
  before :each do
    @user = create(:user, :super_admin)
    sign_in @user
  end
  let!(:tenant) { FactoryBot.create(:tenant) }

  it 'GET #index' do
    get :index
    expect(response).to have_http_status(200)
  end

  it 'GET #show' do
    get :show, params: { id: tenant.id }
    expect(response).to have_http_status(200)
  end
end
