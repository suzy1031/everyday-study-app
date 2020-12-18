require 'rails_helper'

RSpec.describe 'Api::UsersController' do
  describe 'POST #create' do
    let(:user_params) { { email: 'test@email.com', password: 'password', password_confirmation: 'password' } }

    context 'creates a new user' do
      before do
        expect{ post '/api/signup', { params: user_params } }.to change(User, :count).by(1)
      end

      it 'returns http success' do
        expect(response).to be_successful
        expect(response_json.keys).to eq ['csrf']
        expect(response.cookies[JWTSessions.access_cookie]).to be_present
      end
    end
  end
end
