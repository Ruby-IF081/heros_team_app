require 'rails_helper'

RSpec.describe Account::TenantsController, type: :controller do
  before :each do
    @user = create(:user, :super_admin)
    sign_in @user
  end
  let!(:tenant) { FactoryBot.create(:tenant) }
  render_views

  it 'GET #index' do
    get :index
    expect(response).to have_http_status(200)
    expect(response).to render_template(:index)
    expect(response.body).to match(tenant.name)
  end

  it 'GET #show' do
    get :show, params: { id: tenant.id }
    expect(response).to have_http_status(200)
  end
end
