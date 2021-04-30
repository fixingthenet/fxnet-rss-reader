require 'rails_helper'

RSpec.describe "app_configurations#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/app_configurations/#{app_configuration.id}", params: params
  end

  describe 'basic fetch' do
    let!(:app_configuration) { create(:app_configuration) }

    it 'works' do
      expect(AppConfigurationResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('app_configurations')
      expect(d.id).to eq(app_configuration.id)
    end
  end
end
