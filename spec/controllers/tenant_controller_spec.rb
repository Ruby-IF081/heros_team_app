require 'rails_helper'

RSpec.describe Account::TenantsController, type: :controller do
  before :each do
    @user = create(:user)
    sign_in @user
  end
  let!(:tenant) { FactoryBot.create(:tenant) }

  it 'GET #index' do
    get :index
    expect(response).to have_http_status(200)
  end

  it 'GET #show' do
    get :index, params: { id: tenant.id }
    expect(response).to have_http_status(200)
  end

  it "GET #new" do
    get :new
    expect(response).to have_http_status(200)
  end

  it "GET #edit" do
    get :edit, params: { id: tenant.id }
    expect(response).to have_http_status(200)
  end

  describe 'DELETE destroy' do
    it "delete tenant" do
      expect { delete :destroy, params: { id: tenant.id } }.to change(Tenant, :count).by(-1)
    end

    it "redirect to Tenant#index" do
      delete :destroy, params: { id: tenant.id }
      expect(response).to have_http_status(302)
    end
  end
end
