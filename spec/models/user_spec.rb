require 'rails_helper'

RSpec.describe User, type: :model do

  it 'is valid with first name, last name, e-mail and password' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it 'is invalid without first name' do
    user = FactoryBot.build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it 'is invalid without last name' do
    user = FactoryBot.build(:user, last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it 'is invalid without e-mail' do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid with duplicate e-mail' do
    first_user = FactoryBot.build(:user, email: 'example@gmail.com')
    first_user.save
    second_user = FactoryBot.build(:user, email: 'example@gmail.com')
    second_user.valid?
    expect(second_user.errors[:email]).to include('has already been taken')
  end

end
