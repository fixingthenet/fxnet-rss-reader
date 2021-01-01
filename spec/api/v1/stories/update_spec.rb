require 'rails_helper'

RSpec.describe "stories#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/stories/#{story.id}", payload
  end

  describe 'basic update' do
    let!(:story) { create(:story) }

    let(:payload) do
      {
        data: {
          id: story.id.to_s,
          type: 'stories',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(StoryResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { story.reload.attributes }
    end
  end
end
