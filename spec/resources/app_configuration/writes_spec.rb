require 'rails_helper'

RSpec.describe AppConfigurationResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'app_configurations',
          attributes: attributes_for(:app_configuration)
        }
      }
    end

    let(:instance) do
      AppConfigurationResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { AppConfiguration.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:app_configuration) { create(:app_configuration) }

    let(:payload) do
      {
        data: {
          id: app_configuration.id.to_s,
          type: 'app_configurations',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      AppConfigurationResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { app_configuration.reload.updated_at }
      # .and change { app_configuration.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:app_configuration) { create(:app_configuration) }

    let(:instance) do
      AppConfigurationResource.find(id: app_configuration.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { AppConfiguration.count }.by(-1)
    end
  end
end
