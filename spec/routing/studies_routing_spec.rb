require "rails_helper"

RSpec.describe Api::V1::StudiesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(:get => '/api/v1/studies').to route_to('format'=>'json', 'controller'=>'api/v1/studies', 'action'=>'index')
    end

    it 'routes to #create' do
      expect(:post => '/api/v1/studies').to route_to('format'=>'json', 'controller'=>'api/v1/studies', 'action'=>'create')
    end

    it 'routes to #histories' do
      expect(:get => '/api/v1/histories').to route_to('format'=>'json', 'controller'=>'api/v1/studies', 'action'=>'history')
    end
  end
end