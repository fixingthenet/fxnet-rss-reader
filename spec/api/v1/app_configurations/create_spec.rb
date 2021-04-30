require 'rails_helper'

RSpec.describe "app_configurations#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/app_configurations", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:app_configuration)
    end
    let(:payload) do
      {
        data: {
          type: 'app_configurations',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(AppConfigurationResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { AppConfiguration.count }.by(1)
    end
  end
end
