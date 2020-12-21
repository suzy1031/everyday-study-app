require 'rails_helper'

describe 'api::v1::StudiesController' do
  context 'get API' do
    it 'returns JSON for studies' do
      study = create :study

      get '/api/v1/studies'
      json = JSON.parse(response.body)

      expect(response.status).to eq(200)

      expect(json.size).to eq(1)
      study_json = json[0]
      expect(study_json['time']).to eq study.time
      expect(study_json['total']).to eq study.total
    end
  end

  context 'post API success' do
    before do
      valid_params = { time: 0.5, total: 1 }
      expect{ post '/api/v1/studies', params: { study: valid_params } }.to change(Study, :count).by(+1)
    end

    it 'with valid params' do
      expect(response.status).to eq(201)
    end
  end

  context 'post API failure' do
    before do
      invalid_params = { time: nil, total: nil }
      post '/api/v1/studies', params: { study: invalid_params }
    end

    it 'with invalid params' do
      expect(response.status).to eq(422)
    end
  end
end