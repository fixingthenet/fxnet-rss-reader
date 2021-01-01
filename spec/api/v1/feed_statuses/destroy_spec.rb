require 'rails_helper'

RSpec.describe "feed_statuses#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/feed_statuses/#{feed_status.id}"
  end

  describe 'basic destroy' do
    let!(:feed_status) { create(:feed_status) }

    it 'updates the resource' do
      expect(FeedStatusResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { FeedStatus.count }.by(-1)
      expect { feed_status.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
