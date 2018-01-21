require 'rails_helper'

RSpec.describe Api::ApiResponseController, type: :controller do
  let!(:user) { create(:user, :admin) }

  describe 'action #create' do
    context 'with valid tokens' do
      it 'should respond with companies data' do
        request.headers['Authorization'] = "Token token=#{user.auth_token}"
        get :index

        expect(response.body).to have_text('companies')
        expect(response).to have_http_status(:ok)
      end

      it 'should respond with data on correct amount of companies' do
        10.times { create(:company, user: user) }

        request.headers['Authorization'] = "Token token=#{user.auth_token}"
        get :index
        parsed_response = JSON.parse(response.body)

        expect(response.body).to have_text('companies')
        expect(parsed_response['companies'].length).to eq(10)
      end
    end

    context 'with invalid token' do
      it 'should not respond with companies data' do
        request.headers['Authorization'] = 'Token token=123'
        get :index

        expect(response).to have_http_status(401)
        expect(response.body).to have_text('Access denied')
      end
    end
  end
end
