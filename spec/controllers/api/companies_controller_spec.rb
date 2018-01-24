require 'rails_helper'

RSpec.describe Api::CompaniesController, type: :controller do
  let!(:user) { create(:user, :admin) }
  before(:each) do
    user.generate_auth_token
    user.save
    request.headers['Authorization'] = "Token token=#{user.auth_token}"
  end

  describe 'action #index' do
    context 'with valid tokens' do
      it 'should respond with companies data' do
        get :index, as: :json

        expect(response.body).to have_text('companies')
        expect(response).to have_http_status(:ok)
      end

      it 'should respond with data on correct amount of companies' do
        create_list(:company, 10, user: user)

        get :index, as: :json
        parsed_response = JSON.parse(response.body)

        expect(response.body).to have_text('companies')
        expect(parsed_response['companies'].length).to eq(10)
      end
    end

    context 'with invalid token' do
      it 'should not respond with companies data' do
        request.headers['Authorization'] = 'Token token=123'
        get :index, as: :json

        expect(response).to have_http_status(401)
        expect(response.body).to have_text('Access denied')
      end

      context 'with incorrect created_at' do
        it 'should not respond with companies data when token expired' do
          user.update_columns(token_created_at: 2.month.ago)
          get :index, as: :json

          expect(response).to have_http_status(401)
          expect(response.body).to have_text('Your key is expired')
        end

        it 'should not respond with companies data when token nil' do
          user.update_columns(token_created_at: nil)
          get :index, as: :json

          expect(response).to have_http_status(401)
          expect(response.body).to have_text('Your key is expired')
        end
      end
    end
  end
end
