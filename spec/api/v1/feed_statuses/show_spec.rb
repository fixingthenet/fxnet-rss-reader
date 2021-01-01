require 'rails_helper'

RSpec.describe "feed_statuses#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/feed_statuses/#{feed_status.id}", params: params
  end

  describe 'basic fetch' do
    let!(:feed_status) { create(:feed_status) }

    it 'works' do
      expect(FeedStatusResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('feed_statuses')
      expect(d.id).to eq(feed_status.id)
    end
  end
end
