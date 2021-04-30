require 'rails_helper'

RSpec.describe "app_configurations#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/app_configurations/#{app_configuration.id}"
  end

  describe 'basic destroy' do
    let!(:app_configuration) { create(:app_configuration) }

    it 'updates the resource' do
      expect(AppConfigurationResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { AppConfiguration.count }.by(-1)
      expect { app_configuration.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
