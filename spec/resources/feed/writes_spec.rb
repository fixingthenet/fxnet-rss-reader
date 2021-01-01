require 'rails_helper'

RSpec.describe FeedResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'feeds',
          attributes: attributes_for(:feed)
        }
      }
    end

    let(:instance) do
      FeedResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Feed.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:feed) { create(:feed) }

    let(:payload) do
      {
        data: {
          id: feed.id.to_s,
          type: 'feeds',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      FeedResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { feed.reload.updated_at }
      # .and change { feed.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:feed) { create(:feed) }

    let(:instance) do
      FeedResource.find(id: feed.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Feed.count }.by(-1)
    end
  end
end
