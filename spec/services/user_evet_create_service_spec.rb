# spec/services/user_event_create_service_spec.rb
require 'rails_helper'

RSpec.describe UserEventCreateService do
  let(:event_params) { { user_id: 1, event_id: 2 } }

  describe '#call' do
    context 'with valid event params' do
      let(:result) { 
        {
          success: true,
          data: {
            id: 1
          }
        } 
      }

      let(:adapter) { double('Adapter', call: result
      )}

      let(:service) { described_class.new(event_params: event_params, adapter: adapter) }

      it 'calls the adapter with the event params' do
        expect(adapter).to receive(:call).with(row_attrs: event_params)
        service.call
      end

      it 'returns true' do
        expect(service.call[:success]).to eq(true)
      end
    end

    context 'with invalid event params' do
      let(:result) { 
        {
          success: false
        } 
      }
      let(:adapter) { double('Adapter', call: result) }
      let(:service) { described_class.new(event_params: event_params, adapter: adapter) }

      it 'does not call the adapter' do
        expect(adapter).to receive(:call).with(row_attrs: event_params)
        service.call
      end

      it 'returns false' do
        expect(service.call[:success]).to eq(false)
      end
    end
  end
end
