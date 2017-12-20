require 'rails_helper'

RSpec.describe Account::PagesController, type: :controller do
  context 'Page' do
    let!(:page) { FactoryBot.create(:page) }

    it 'Get#index' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'Get#show' do
      get :index, params: { id: page.id }
      expect(response).to have_http_status(:success)
    end
  end
end
