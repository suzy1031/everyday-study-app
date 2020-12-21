require 'rails_helper'
RSpec.describe Api::SessionsController, type: :controller do
  let(:user) { create(:user) }

  describe 'POST #create' do
    let(:password) { 'password' }
    let(:user_params) { { email: user.email, password: password } }
    let(:user_invalid_params) { { email: user.email, password: 'incorrect' } }

    it 'returns http success' do
      post :create, params: user_params
      expect(response).to be_successful
      expect(response_json.keys).to eq ['csrf']
      expect(response.cookies[JWTSessions.access_cookie]).to be_present
    end

    it 'returns unauthorized for invalid params' do
      post :create, params: user_invalid_params
      expect(response).to have_http_status(404)
    end
  end
end