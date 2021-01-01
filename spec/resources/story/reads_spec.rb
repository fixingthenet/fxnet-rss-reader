require 'rails_helper'

RSpec.describe StoryResource, type: :resource do
  describe 'serialization' do
    let!(:story) { create(:story) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(story.id)
      expect(data.jsonapi_type).to eq('stories')
    end
  end

  describe 'filtering' do
    let!(:story1) { create(:story) }
    let!(:story2) { create(:story) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: story2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([story2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:story1) { create(:story) }
      let!(:story2) { create(:story) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            story1.id,
            story2.id
          ])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            story2.id,
            story1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
