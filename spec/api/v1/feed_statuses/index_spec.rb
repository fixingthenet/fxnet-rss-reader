require 'rails_helper'

RSpec.describe "feed_statuses#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/feed_statuses", params: params
  end

  describe 'basic fetch' do
    let!(:feed_status1) { create(:feed_status) }
    let!(:feed_status2) { create(:feed_status) }

    it 'works' do
      expect(FeedStatusResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['feed_statuses'])
      expect(d.map(&:id)).to match_array([feed_status1.id, feed_status2.id])
    end
  end
end
