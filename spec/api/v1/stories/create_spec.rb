require 'rails_helper'

RSpec.describe "stories#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/stories", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:story)
    end
    let(:payload) do
      {
        data: {
          type: 'stories',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(StoryResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { Story.count }.by(1)
    end
  end
end
