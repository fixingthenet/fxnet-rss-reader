require 'rails_helper'

RSpec.describe "feeds#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/feeds", params: params
  end

  describe 'basic fetch' do
    let!(:feed1) { create(:feed) }
    let!(:feed2) { create(:feed) }

    it 'works' do
      expect(FeedResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['feeds'])
      expect(d.map(&:id)).to match_array([feed1.id, feed2.id])
    end
  end
end
