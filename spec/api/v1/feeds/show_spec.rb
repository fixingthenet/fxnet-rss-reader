require 'rails_helper'

RSpec.describe "feeds#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/feeds/#{feed.id}", params: params
  end

  describe 'basic fetch' do
    let!(:feed) { create(:feed) }

    it 'works' do
      expect(FeedResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('feeds')
      expect(d.id).to eq(feed.id)
    end
  end
end
