require 'rails_helper'

RSpec.describe Account::TokensController, type: :controller do
  let!(:user) { create(:user, :admin) }
  before(:each) { sign_in user }

  describe 'action #generate_token' do
    it 'should change users token attributes' do
      old_token = user.auth_token
      old_time = user.token_created_at
      post :create, xhr: true
      user.reload

      expect(user.auth_token).not_to eq(old_token)
      expect(user.token_created_at).not_to eq(old_time)
    end

    it 'should not redirect to the profile show' do
      post :create, xhr: true

      expect(response).not_to have_http_status(302)
      expect(response).not_to redirect_to(account_profile_path)
      expect(controller).not_to set_flash[:success]
    end
  end

  describe 'action #deactivate_token' do
    it 'should destroy users token attributes' do
      delete :destroy, xhr: true
      user.reload

      expect(user.auth_token).to eq(nil)
      expect(user.token_created_at).to eq(nil)
    end

    it 'should not redirect to the profile show' do
      delete :destroy, xhr: true

      expect(response).not_to have_http_status(302)
      expect(response).not_to redirect_to(account_profile_path)
      expect(controller).not_to set_flash[:info]
    end
  end
end
