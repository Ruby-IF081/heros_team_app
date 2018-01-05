require 'rails_helper'

RSpec.describe Account::ChromeExtensionsController, type: :controller do
  let!(:company) { create(:company) }
  before(:each) { sign_in company.user }

  describe 'GET #new' do
    it 'renders the #new view' do
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let!(:valid_page) { build(:page) }
      it 'add page' do
        expect do
          post :create, params: { page: { title: valid_page.title,
                                          source_url: valid_page.source_url,
                                          company_id: company.id } }
        end.to change(Page, :count).by(1)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to account_company_pages_path(company)
      end
    end

    context 'with invalid attributes' do
      let!(:valid_page) { build(:page) }
      it('add page') do
        expect do
          post :create, params: { page: { title: '',
                                          source_url: '',
                                          company_id: company.id } }
        end.not_to(change { Page.count })
      end
    end
  end
end
