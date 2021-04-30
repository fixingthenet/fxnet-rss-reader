require 'rails_helper'

RSpec.describe AppConfigurationResource, type: :resource do
  describe 'serialization' do
    let!(:app_configuration) { create(:app_configuration) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(app_configuration.id)
      expect(data.jsonapi_type).to eq('app_configurations')
    end
  end

  describe 'filtering' do
    let!(:app_configuration1) { create(:app_configuration) }
    let!(:app_configuration2) { create(:app_configuration) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: app_configuration2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([app_configuration2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:app_configuration1) { create(:app_configuration) }
      let!(:app_configuration2) { create(:app_configuration) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            app_configuration1.id,
            app_configuration2.id
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
            app_configuration2.id,
            app_configuration1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
