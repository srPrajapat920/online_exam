# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'User validation' do
    it 'has valid factory' do
      expect(FactoryBot.build(:user)).to be_valid
    end
    it 'is invalid without username' do
      expect(FactoryBot.build(:user, username: nil)).to be_invalid
    end
    it 'is invalid without email id' do
      expect(FactoryBot.build(:user, email_id: nil)).to be_invalid
    end
    it 'is invalid without password' do
      expect(FactoryBot.build(:user, password: nil)).to be_invalid
    end
    it 'is invalid without contact number' do
      expect(FactoryBot.build(:user, contact_no: nil)).to be_invalid
    end
    it 'is invalid without level' do
      expect(FactoryBot.build(:user, level: nil)).to be_invalid
    end
    it 'is invalid without proper format of email id' do
      expect(FactoryBot.build(:user, email_id: 'sanjay3555.in')).to be_invalid
    end
    it 'is convert email id into downcase' do
      @user = FactoryBot.build(:user)
      @user.email_id.downcase
    end
    it 'is invalid to has length out of range of password' do
      expect(FactoryBot.build(:user, password: 'njh3')).to be_invalid
    end
    it 'is invalid with grater than 10 digit contact_no' do
      expect(
        FactoryBot.build(:user, contact_no: '985348483949394')
      ).to be_invalid
    end
    it 'is invalid with less than 10 digit contact_no' do
      expect(FactoryBot.build(:user, contact_no: '9853')).to be_invalid
    end
    it 'is invalid take character for contact_no' do
      expect(FactoryBot.build(:user, contact_no: 'gbfjf12')).to be_invalid
    end
  end

  context 'authenticate method' do
    before :each do
      @user2 = FactoryBot.create(:user)
      @attr = { session: { email_id: @user2.email_id, password: @user2.password } }
    end
    it 'should return nil on email/password mismatch' do
      wrong_password_user = User.authenticate(@attr[:session][:email_id], 'wrongpass')
      expect(wrong_password_user).to eq(nil)
    end
    it 'should return nil for an email address with no user' do
      nonexistent_user = User.authenticate('bar@foo.com', @attr[:session][:password])
      expect(nonexistent_user).to eq(nil)
    end
    it 'should return the user on email/password match' do
      matching_user = User.authenticate(@attr[:session][:email_id], @attr[:session][:password])
      expect(matching_user).to eq(@user2)
    end
    it 'should set the encrypted password' do
      expect(@user2.password_hash).to_not be_blank
    end
  end
end
