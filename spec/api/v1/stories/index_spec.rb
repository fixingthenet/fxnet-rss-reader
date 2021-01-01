require 'rails_helper'

RSpec.describe "stories#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/stories", params: params
  end

  describe 'basic fetch' do
    let!(:story1) { create(:story) }
    let!(:story2) { create(:story) }

    it 'works' do
      expect(StoryResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['stories'])
      expect(d.map(&:id)).to match_array([story1.id, story2.id])
    end
  end
end
