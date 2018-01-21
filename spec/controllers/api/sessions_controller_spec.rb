require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  let!(:user) { create(:user, :admin) }

  describe 'action #create' do
    context 'with valid attributes' do
      it 'should change users token attributes' do
        old_token = user.auth_token
        old_time = user.token_created_at
        post :create, params: { user_login: { email: user.email, password: user.password } }
        user.reload

        expect(response).to have_http_status(200)
        expect(response.body).to have_text('auth_token')
        expect(response.body).to have_text(user.auth_token)
        expect(user.auth_token).not_to eq(old_token)
        expect(user.token_created_at).not_to eq(old_time)
      end
    end

    context 'with invalid attributes' do
      it 'should not change users token attributes' do
        old_token = user.auth_token
        post :create, params: { user_login: { email: user.email, password: '1234' } }
        user.reload

        expect(response).to have_http_status(401)
        expect(response.body).to have_text('Error with your login or password')
        expect(response.body).not_to have_text(user.auth_token)
        expect(user.auth_token).to eq(old_token)
      end
    end
  end

  describe 'action #create' do
    context 'with valid tokens' do
      it 'should destroy users token attributes' do
        request.headers['Authorization'] = "Token token=#{user.auth_token}"
        delete :destroy
        user.reload

        expect(user.auth_token).to eq(nil)
        expect(user.token_created_at).to eq(nil)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid token' do
      it 'should not destroy users token attributes' do
        old_token = user.auth_token
        request.headers['Authorization'] = 'Token token=123'
        delete :destroy
        user.reload

        expect(response).to have_http_status(401)
        expect(response.body).to have_text('Access denied')
        expect(user.auth_token).to eq(old_token)
      end
    end
  end
end
