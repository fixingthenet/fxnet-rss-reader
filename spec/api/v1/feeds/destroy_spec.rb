require 'rails_helper'

RSpec.describe "feeds#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/feeds/#{feed.id}"
  end

  describe 'basic destroy' do
    let!(:feed) { create(:feed) }

    it 'updates the resource' do
      expect(FeedResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Feed.count }.by(-1)
      expect { feed.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
