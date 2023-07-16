require 'rails_helper'
# require 'pp'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should be created with password and password_confirmation fields' do
      user = User.new(
        email: 'test@example.com',
        first_name: 'Billy',
        last_name: 'Bob',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user.save).to be true
    end

    it 'should have matching password and password_confirmation' do
      user = User.new(
        email: 'test@example.com',
        first_name: 'Billy',
        last_name: 'Bob',
        password: 'password',
        password_confirmation: 'password1'
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should require password and password_confirmation fields' do
      user = User.new(email: 'test@example.com')
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should require unique email (case-insensitive)' do
      User.create(
        email: 'test@example.com',
        first_name: 'Billy',
        last_name: 'Bob',
        password: 'password',
        password_confirmation: 'password'
      )
      user = User.new(
        email: 'TEST@example.com',
        first_name: 'Billy',
        last_name: 'Bob',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'should require email, first name, and last name' do
      user = User.new(
        email: nil,
        first_name: nil,
        last_name: nil,
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user.save).to be false
      expect(user.errors.full_messages).to include("Email can't be blank")
      expect(user.errors.full_messages).to include("First name can't be blank")
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(
        email: 'test@example.com',
        first_name: 'Billy',
        last_name: 'Bob',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    it 'should return a user instance if authentication is successful' do
      authenticate_user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(authenticate_user).to eq(@user)
    end

    it 'should return nil if authentication is fails' do
      authenticate_user = User.authenticate_with_credentials('test@example.com', 'password1')
      expect(authenticate_user).to be_nil
    end

    it 'should authenticate successfully with leading/trailing whitespaces in email' do
      authenticate_user = User.authenticate_with_credentials('  test@example.com  ', 'password')
      expect(authenticate_user).to eq(@user)
    end

    it 'should authenticate successfully with different case in email' do
      authenticate_user = User.authenticate_with_credentials('TEST@example.com  ', 'password')
      expect(authenticate_user).to eq(@user)
    end
  end
end