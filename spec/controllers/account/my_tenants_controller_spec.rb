require 'rails_helper'

RSpec.describe Account::MyTenantsController, type: :controller do
  before :each do
    @user = create(:user, :admin)
    sign_in @user
  end
  let!(:tenant) { @user.tenant }

  describe 'GET #show' do
    it 'assigns the requested tenant to @tenant' do
      get :show, params: { id: tenant.id }
      expect(assigns(:tenant)).to eq(tenant)
    end

    it 'renders the show view' do
      get :show
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested tenant to @tenant' do
      get :show, params: { id: tenant.id }
      expect(assigns(:tenant)).to eq(tenant)
    end

    it 'renders the edit view' do
      get :edit
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT #update' do
    context 'valid attributes' do
      it 'locates the requested @tenant' do
        put :update, params: { id: tenant.id,
                               tenant: { name: tenant.name,
                                         website: tenant.website } }
        expect(assigns(:tenant)).to eq(tenant)
      end

      it 'changes tenants attributes' do
        put :update, params: { id: tenant.id,
                               tenant: { name: 'Valid tenant name',
                                         website: 'valid_domain.com' } }
        tenant.reload
        expect(tenant.name).to eq('Valid tenant name')
        expect(tenant.website).to eq('valid_domain.com')
      end

      it 'redirects to the updated tenant with success flash' do
        put :update, params: { id: tenant.id,
                               tenant: { name: 'Valid tenant name',
                                         website: 'valid_domain.com' } }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to account_my_tenant_path
        expect(flash[:success]).to_not eq nil
      end
    end

    context 'invalid attributes' do
      it 'locates the requested @tenant' do
        put :update, params: { id: tenant.id,
                               tenant: { name: nil,
                                         website: 'invalid_domain,com' } }
        expect(assigns(:tenant)).to eq(tenant)
      end

      it 'does not change tenants attributes' do
        put :update, params: { id: tenant.id,
                               tenant: { name: nil,
                                         website: 'invalid_domain,com' } }
        tenant.reload
        expect(tenant.name).to_not eq(nil)
        expect(tenant.website).to_not eq('invalid_domain,com')
      end

      it 're-renders the edit view' do
        put :update, params: { id: tenant.id,
                               tenant: { name: nil,
                                         website: 'invalid_domain,com' } }
        expect(response).to have_http_status(200)
        expect(response).to render_template(:edit)
      end
    end
  end
end
