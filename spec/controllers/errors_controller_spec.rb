require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do
  it 'GET #not_found' do
    get :not_found
    expect(response).to have_http_status(404)
    expect(response).to render_template(:not_found)
  end

  it 'GET #unacceptable' do
    get :unacceptable
    expect(response).to have_http_status(422)
    expect(response).to render_template(:unacceptable)
  end

  it 'GET #internal_error' do
    get :internal_error
    expect(response).to have_http_status(500)
    expect(response).to render_template(:internal_error)
  end
end
