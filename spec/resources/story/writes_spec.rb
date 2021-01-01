require 'rails_helper'

RSpec.describe StoryResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'stories',
          attributes: attributes_for(:story)
        }
      }
    end

    let(:instance) do
      StoryResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Story.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:story) { create(:story) }

    let(:payload) do
      {
        data: {
          id: story.id.to_s,
          type: 'stories',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      StoryResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { story.reload.updated_at }
      # .and change { story.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:story) { create(:story) }

    let(:instance) do
      StoryResource.find(id: story.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Story.count }.by(-1)
    end
  end
end
