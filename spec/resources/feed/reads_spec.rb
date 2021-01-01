require 'rails_helper'

RSpec.describe FeedResource, type: :resource do
  describe 'serialization' do
    let!(:feed) { create(:feed) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(feed.id)
      expect(data.jsonapi_type).to eq('feeds')
    end
  end

  describe 'filtering' do
    let!(:feed1) { create(:feed) }
    let!(:feed2) { create(:feed) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: feed2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([feed2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:feed1) { create(:feed) }
      let!(:feed2) { create(:feed) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            feed1.id,
            feed2.id
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
            feed2.id,
            feed1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
