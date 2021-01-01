require 'rails_helper'

RSpec.describe "feeds#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/feeds", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:feed)
    end
    let(:payload) do
      {
        data: {
          type: 'feeds',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(FeedResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { Feed.count }.by(1)
    end
  end
end
