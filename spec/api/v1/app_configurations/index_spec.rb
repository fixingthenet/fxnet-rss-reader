require 'rails_helper'

RSpec.describe "app_configurations#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/app_configurations", params: params
  end

  describe 'basic fetch' do
    let!(:app_configuration1) { create(:app_configuration) }
    let!(:app_configuration2) { create(:app_configuration) }

    it 'works' do
      expect(AppConfigurationResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['app_configurations'])
      expect(d.map(&:id)).to match_array([app_configuration1.id, app_configuration2.id])
    end
  end
end
