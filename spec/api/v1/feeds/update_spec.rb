require 'rails_helper'

RSpec.describe "feeds#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/feeds/#{feed.id}", payload
  end

  describe 'basic update' do
    let!(:feed) { create(:feed) }

    let(:payload) do
      {
        data: {
          id: feed.id.to_s,
          type: 'feeds',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(FeedResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { feed.reload.attributes }
    end
  end
end
