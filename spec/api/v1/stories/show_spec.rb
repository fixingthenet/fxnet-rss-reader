require 'rails_helper'

RSpec.describe "stories#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/stories/#{story.id}", params: params
  end

  describe 'basic fetch' do
    let!(:story) { create(:story) }

    it 'works' do
      expect(StoryResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('stories')
      expect(d.id).to eq(story.id)
    end
  end
end
