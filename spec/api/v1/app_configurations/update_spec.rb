require 'rails_helper'

RSpec.describe "app_configurations#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/app_configurations/#{app_configuration.id}", payload
  end

  describe 'basic update' do
    let!(:app_configuration) { create(:app_configuration) }

    let(:payload) do
      {
        data: {
          id: app_configuration.id.to_s,
          type: 'app_configurations',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(AppConfigurationResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { app_configuration.reload.attributes }
    end
  end
end
