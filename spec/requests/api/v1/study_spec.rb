require 'rails_helper'

describe 'PostAPI' do
  it 'Returns JSON for studies' do
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