require 'rails_helper'

RSpec.describe FeedStatusResource, type: :resource do
  describe 'serialization' do
    let!(:feed_status) { create(:feed_status) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(feed_status.id)
      expect(data.jsonapi_type).to eq('feed_statuses')
    end
  end

  describe 'filtering' do
    let!(:feed_status1) { create(:feed_status) }
    let!(:feed_status2) { create(:feed_status) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: feed_status2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([feed_status2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:feed_status1) { create(:feed_status) }
      let!(:feed_status2) { create(:feed_status) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            feed_status1.id,
            feed_status2.id
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
            feed_status2.id,
            feed_status1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
