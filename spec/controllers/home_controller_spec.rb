require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  it 'GET #INDEX' do
    get :index
    expect(response).to have_http_status(:success)
  end
end
