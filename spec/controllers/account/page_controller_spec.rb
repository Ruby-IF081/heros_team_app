require 'rails_helper'

RSpec.describe Account::PagesController, sidekiq: true, type: :controller do
  context 'Page' do
    let!(:page) { create(:page) }
    before(:each) { sign_in page.company.user }

    it 'GET #index' do
      get :index, params: { company_id: page.company.to_param }
      expect(response).to have_http_status(:success)
    end

    it 'GET #show' do
      get :index, params: { company_id: page.company.to_param, id: page }
      expect(response).to have_http_status(:success)
    end

    it 'PATCH #rate with valid values' do
      new_rating = 100
      patch :rate, params: { company_id: page.company.to_param,
                             id: page, page: { rating: new_rating } }
      page.reload
      expect(page.rating).to eq(new_rating)
    end

    it 'PATCH #rate with invalid values' do
      old_rating = page.rating
      invalid_rating = 1_000_000
      patch :rate, params: { company_id: page.company.to_param,
                             id: page, page: { rating: invalid_rating } }
      page.reload
      expect(page.rating).to eq(old_rating)
    end
  end
end
