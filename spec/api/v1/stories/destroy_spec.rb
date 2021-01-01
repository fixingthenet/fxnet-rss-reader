require 'rails_helper'

RSpec.describe "stories#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/stories/#{story.id}"
  end

  describe 'basic destroy' do
    let!(:story) { create(:story) }

    it 'updates the resource' do
      expect(StoryResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Story.count }.by(-1)
      expect { story.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
