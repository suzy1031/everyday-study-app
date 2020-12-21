require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do

  describe 'POST #create' do
    let(:user_params) { { email: 'test@email.com', password: 'password', password_confirmation: 'password'  } }
    let(:invalid_params) { { email: 'test@email.com', password: 'password', password_confirmation: 'incorrect' } }

    it 'returns http success' do
      post :create, params: user_params
      expect(response).to be_successful
      expect(response_json.keys).to eq ['csrf']
      expect(response.cookies[JWTSessions.access_cookie]).to be_present
    end

    it 'creates a new user' do
      expect do
        post :create, params: user_params
      end.to change(User, :count).by(1)
    end

    it 'Returns unauthorized for invalid params' do
      post :create, params: invalid_params
      expect(response).to have_http_status(422)
    end
  end
end