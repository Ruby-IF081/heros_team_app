require 'rails_helper'

RSpec.describe Account::TenantsController, type: :controller do
  before :each do
    @user = create(:user)
    sign_in @user
  end
  let!(:tenant) { FactoryBot.create(:tenant) }

  it 'GET #index' do
    get :index
    expect(response).to have_http_status(403)
  end

  it 'GET #show' do
    get :index, params: { id: tenant.id }
    expect(response).to have_http_status(403)
  end
end
