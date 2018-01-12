require 'rails_helper'

feature 'Landing page' do
  scenario 'signed in' do
    user = create(:user)

    visit new_user_session_path
    fill_in 'Your email', with: user.email
    fill_in 'Your password', with: user.password
    click_button 'Log In'

    visit home_path

    within('.header-navbar') do
      expect(page).to have_text('home')
      expect(page).to have_text('Log out')
    end

    within('footer') do
      expect(page).not_to have_text('home')
    end
  end

  scenario 'not signed in' do
    visit root_path

    within('.header-navbar') do
      expect(page).to have_text('home')
    end

    within('footer') do
      expect(page).not_to have_text('home')
    end
  end
end
