require 'rails_helper'

RSpec.describe Api::V1::GoalsController, type: :controller do
  let(:user) { create(:user) }

  let(:valid_params) {
    { target_time: 10.0 }
  }

  let(:invalid_params) {
    { target_time: nil }
  }

  before do
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload)
    @tokens = session.login
  end
  describe 'GET #index' do
    let!(:goal) { create(:goal, user: user) }

    it 'return a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :index
      expect(response).to be_successful
      expect(response_json.size).to eq(1)
      expect(response_json.first['id']).to eq goal.id
      expect(response).to have_http_status(200)
    end

    it 'is unauth without cookie' do
      request.cookies[JWTSessions.access_cookie] = nil
      get :index
      expect(response).to have_http_status(500)
    end
  end

  describe 'POST #create' do
    context 'with a valid params' do
      it 'create a new goal' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        expect {
          post :create, params: { goal: valid_params }
        }.to change{ Goal.count }.by(1)
      end

      it 'returns a JSON response with the new goal' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { goal: valid_params }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
      end

      it 'is unauth without CSRF' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        post :create, params: { goal: valid_params }
        expect(response).to have_http_status(500)
      end
    end

    context 'with a invalid params' do
      it 'renders a JSON response with errors for the new goal' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { goal: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end

    describe 'PUT #update' do
      let!(:goal) { create(:goal, user: user) }

      context 'with a valid params' do
        let(:new_params) {
          { target_time: 12.0 }
        }
        it 'updates the requested goal' do
          request.cookies[JWTSessions.access_cookie] = @tokens[:access]
          request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
          put :update, params: { id: goal.id, goal: new_params }
          goal.reload
          expect(goal.target_time).to eq new_params[:target_time]
        end

        it 'renders a JSON response with the todo' do
          request.cookies[JWTSessions.access_cookie] = @tokens[:access]
          request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
          put :update, params: { id: goal.to_param, goal: valid_params }
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq('application/json')
        end
      end

      context 'with invalid params' do
        it 'renders a JSON with errors for the goal' do
          request.cookies[JWTSessions.access_cookie] = @tokens[:access]
          request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
          put :update, params: { id: goal.to_param, goal: invalid_params }
          expect(response).to have_http_status(500)
          expect(response.content_type).to eq('application/json')
        end
      end
    end
  end
end