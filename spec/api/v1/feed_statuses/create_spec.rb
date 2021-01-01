require 'rails_helper'

RSpec.describe "feed_statuses#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/feed_statuses", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:feed_status)
    end
    let(:payload) do
      {
        data: {
          type: 'feed_statuses',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(FeedStatusResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { FeedStatus.count }.by(1)
    end
  end
end
