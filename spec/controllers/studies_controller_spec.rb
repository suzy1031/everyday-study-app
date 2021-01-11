require 'rails_helper'

RSpec.describe Api::V1::StudiesController, type: :controller do
  let(:user) { create(:user) }

  let(:valid_params) {
    { time: 1, total: 1 }
  }

  let(:invalid_params) {
    { time: nil, total: 1 }
  }

  before do
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload)
    @tokens = session.login
  end

  describe 'GET #index' do
    let!(:study) { create(:study, user: user) }

    it 'returns a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :index
      expect(response).to be_successful
      expect(response_json.size).to eq(1)
      expect(response_json.first['id']).to eq study.id
      expect(response).to have_http_status(200)
    end

    it 'is unauth without cookie' do
      request.cookies[JWTSessions.access_cookie] = nil
      get :index
      expect(response).to have_http_status(500)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new study' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        expect {
          post :create, params: { study: valid_params }
        }.to change(Study, :count).by(1)
      end

      it 'returns a JSON response with the new study' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { study: valid_params }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end

      it 'is unauth without CSRF' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        post :create, params: { study: valid_params }
        expect(response).to have_http_status(500)
      end
    end
    context 'with invalid params' do
      it 'renders a JSON response with errors for the new study' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { study: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end