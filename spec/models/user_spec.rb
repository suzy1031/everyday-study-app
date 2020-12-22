require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    context 'success' do
      before do
        @user = FactoryBot.create(:user)
      end

      it 'is valid with a email, password, password_confirmation' do
        user = @user
        expect(user).to be_valid
      end

      it 'is null with a email' do
        expect(FactoryBot.build(:user, email: '')).to_not be_valid
      end

      it 'is duplicate with a email' do
        anoter_user = FactoryBot.create(:user, email: 'test@email.com')
        expect(FactoryBot.build(:user, email: 'test@email.com')).to_not be_valid
      end

      it 'is not match pattern with a password' do
        expect(FactoryBot.build(:user, email: 'testemail.com')).to_not be_valid
      end

      it 'is null with a password' do
        expect(FactoryBot.build(:user, password: '')).to_not be_valid
      end

      it 'is shorter than 6 charactors with a password' do
        expect(FactoryBot.build(:user, password: 'test')).to_not be_valid
      end

      it 'is longer than 20 charactors with a password' do
        expect(FactoryBot.build(:user, password: 'thisislongerthan20charactorspassword')).to_not be_valid
      end

      it 'is encryption with a password' do
        user = @user
        expect(user.password_digest).to_not eq 'password'
      end

      it 'is not match with a password and password_confirmation' do
        user = @user
        expect(FactoryBot.build(:user, password: 'password', password_confirmation: 'incorrect')).to_not be_valid
      end
    end
  end
end
