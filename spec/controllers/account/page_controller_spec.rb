require 'rails_helper'

RSpec.describe Account::PagesController, type: :controller do
  context 'Page' do
    let!(:page) { FactoryBot.create(:page) }
    before(:each) { sign_in page.company.user }

    it 'GET #index' do
      get :index, params: { company_id: page.company.to_param }
      expect(response).to have_http_status(:success)
    end

    it 'GET #show' do
      get :index, params: { company_id: page.company.to_param, id: page.id }
      expect(response).to have_http_status(:success)
    end
  end
end
