require 'rails_helper'

RSpec.describe User, type: :model do

  it 'is valid with first name, last name, e-mail and password' do
    user = User.new(
      first_name: 'Homer',
      last_name:  'Simpson',
      email:      'homie@gmail.com',
      password:   '1Qaz2Wsx'
    )
    expect(user).to be_valid
  end

  it 'is invalid without first name' do
    user = User.new(first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it 'is invalid without last name' do
    user = User.new(last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it 'is invalid without e-mail' do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid without duplicate e-mail' do
    first_user = User.create(
      first_name: 'Homer',
      last_name:  'Simpson',
      email:      'homie@gmail.com',
      password:   '1Qaz2Wsx'
    )
    second_user = User.new(
      first_name: 'Lisa',
      last_name:  'Simpson',
      email:      'homie@gmail.com',
      password:   '1Qaz2Wsx'
    )
    second_user.valid?
    expect(second_user.errors[:email]).to include('has already been taken')
  end

end
