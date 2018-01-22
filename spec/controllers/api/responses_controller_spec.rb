require 'rails_helper'

RSpec.describe Api::ResponsesController, type: :controller do
  let!(:user) { create(:user, :admin) }

  describe 'action #companies' do
    context 'with valid tokens' do
      it 'should respond with companies data' do
        request.headers['Authorization'] = "Token token=#{user.auth_token}"
        get :companies, as: :json

        expect(response.body).to have_text('companies')
        expect(response).to have_http_status(:ok)
      end

      it 'should respond with data on correct amount of companies' do
        create_list(:company, 10, user: user)

        request.headers['Authorization'] = "Token token=#{user.auth_token}"
        get :companies, as: :json
        parsed_response = JSON.parse(response.body)

        expect(response.body).to have_text('companies')
        expect(parsed_response['companies'].length).to eq(10)
      end
    end

    context 'with invalid token' do
      it 'should not respond with companies data' do
        request.headers['Authorization'] = 'Token token=123'
        get :companies, as: :json

        expect(response).to have_http_status(401)
        expect(response.body).to have_text('Access denied')
      end

      context 'with expired token' do
        it 'should not respond with companies data' do
          user.update_columns(token_created_at: 2.month.ago)
          request.headers['Authorization'] = "Token token=#{user.auth_token}"
          get :companies, as: :json

          expect(response).to have_http_status(401)
          expect(response.body).to have_text('Your key is expired')
        end
      end
    end
  end
end
