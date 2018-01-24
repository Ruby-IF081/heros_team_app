require 'rails_helper'

feature 'Add new company' do
  scenario 'create new company' do
    allow_any_instance_of(FullContactCompanyProcessor).to receive(:call_fullcontact_api)
      .and_return({})
    user = create(:user)

    visit new_user_session_path

    fill_in 'Your email', with: user.email
    fill_in 'Your password', with: user.password
    click_button 'Log In'

    click_link 'Companies'

    expect(page).to have_text('Companies')

    find(:css, 'a[href="/account/companies/new"]').click

    fill_in 'Name', with: 'SoftServe'
    fill_in 'Domain', with: 'softserve.ua'
    click_button 'Create'

    expect(page).to have_text('Company successfully created')
    within('#overview') do
      expect(page).to have_text('SoftServe')
      expect(page).to have_text('softserve.ua')
    end
  end
end
