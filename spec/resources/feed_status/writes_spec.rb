require 'rails_helper'

RSpec.describe FeedStatusResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'feed_statuses',
          attributes: attributes_for(:feed_status)
        }
      }
    end

    let(:instance) do
      FeedStatusResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { FeedStatus.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:feed_status) { create(:feed_status) }

    let(:payload) do
      {
        data: {
          id: feed_status.id.to_s,
          type: 'feed_statuses',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      FeedStatusResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { feed_status.reload.updated_at }
      # .and change { feed_status.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:feed_status) { create(:feed_status) }

    let(:instance) do
      FeedStatusResource.find(id: feed_status.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { FeedStatus.count }.by(-1)
    end
  end
end
