require 'rails_helper'

RSpec.describe TokensController, type: :controller do
  let!(:user) { create(:user, :admin) }
  before(:each) { sign_in user }

  describe 'action #generate_token' do
    it 'should change users token attributes' do
      old_token = user.auth_token
      old_time = user.token_created_at
      post :generate_token
      user.reload

      expect(user.auth_token).not_to eq(old_token)
      expect(user.token_created_at).not_to eq(old_time)
    end

    it 'redirects to the user show' do
      post :generate_token

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(account_user_path(user))
      expect(controller).to set_flash[:success]
    end
  end

  describe 'action #deactivate_token' do
    it 'should destroy users token attributes' do
      delete :deactivate_token
      user.reload

      expect(user.auth_token).to eq(nil)
      expect(user.token_created_at).to eq(nil)
    end

    it 'redirects to the user show' do
      delete :deactivate_token

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(account_user_path(user))
      expect(controller).to set_flash[:info]
    end
  end
end
