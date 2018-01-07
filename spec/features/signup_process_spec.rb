require 'rails_helper'

feature 'Sign up process' do
  scenario 'signs me up' do
    user = build(:user)
    tenant = build(:tenant)

    visit new_user_registration_path
    fill_in 'First Name', with: user.first_name
    fill_in 'Last Name', with: user.last_name
    fill_in 'Please enter email address', with: user.email
    fill_in 'Tenant Name', with: tenant.name
    fill_in 'Password', with: user.password
    fill_in 'Confirm Password', with: user.password
    click_button 'Create Account'

    expect(page).to have_text('Hello to Sales Assistant')
  end
end
