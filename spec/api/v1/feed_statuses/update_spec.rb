require 'rails_helper'

RSpec.describe "feed_statuses#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/feed_statuses/#{feed_status.id}", payload
  end

  describe 'basic update' do
    let!(:feed_status) { create(:feed_status) }

    let(:payload) do
      {
        data: {
          id: feed_status.id.to_s,
          type: 'feed_statuses',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(FeedStatusResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { feed_status.reload.attributes }
    end
  end
end
