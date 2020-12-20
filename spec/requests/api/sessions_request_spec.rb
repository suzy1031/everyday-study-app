require 'rails_helper'

RSpec.describe "Api::SessionsController" do
  let(:user) { create(:user) }

  describe 'POST #create' do
    let(:password) { 'password' }
    let(:user_params) { { email: user.email, password: password } }

    it 'Returns http success' do
      post '/api/signin', params: user_params
      expect(response).to be_successful
      expect(response_json.keys).to eq ['csrf']
      expect(response.cookies[JWTSessions.access_cookie]).to be_present
    end

    it 'Returns unauthorized for invalid params' do
      post '/api/signin', params: { email: user.email, password: 'incorrect' }
      expect(response).to have_http_status(404)
    end
  end
end
