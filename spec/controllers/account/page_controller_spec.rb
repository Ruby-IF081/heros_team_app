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

    it 'PATCH #rate with valid values' do
      new_rating = '+100'
      patch :rate, params: { company_id: page.company.to_param,
                             id: page.id, commit: new_rating }
      page.reload
      expect(page.rating).to eq(new_rating.to_i)
    end

    it 'PATCH #rate with invalid values' do
      new_rating = '+100000'
      patch :rate, params: { company_id: page.company.to_param,
                             id: page.id, commit: new_rating }
      page.reload
      expect(page.rating).not_to eq(new_rating.to_i)
    end
  end
end
