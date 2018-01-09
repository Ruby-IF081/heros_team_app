require 'rails_helper'

RSpec.describe Account::TenantsController, type: :controller do
  let!(:tenant) { FactoryBot.create(:tenant) }
  before(:each) do
    @user = create(:user, :super_admin, tenant: tenant)
    sign_in @user
  end

  describe 'GET #index' do
    it 'populates an array of tenants' do
      get :index
      expect(assigns(:tenants)).to eq([tenant])
    end

    it 'renders the :index view' do
      get :index
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it 'has tenant.name in body' do
      get :index
      expect(response.body).to match(tenant.name)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested tenant to @tenant' do
      get :show, params: { id: tenant.id }
      expect(assigns(:tenant)).to eq(tenant)
    end

    it 'renders the :show view' do
      get :show, params: { id: tenant.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end
end
