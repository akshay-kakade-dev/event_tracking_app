# spec/services/track_event_service_spec.rb
require 'rails_helper'

RSpec.describe TrackEventService do
  describe '#call' do
    let(:user) { instance_double(User, email: 'test@example.com', id: 1) }
    let(:user_event) { instance_double(UserEvent, event: event, user: user) }
    let(:event) { instance_double(Event, title: 'Test Event', id: 1, created_at: Time.now) }
    let(:api_service) { instance_double(Iterable::TrackEventService, call: true) }
    let(:service) { described_class.new(user_event: user_event, api_service: api_service) }

    it 'calls the API service with the generated event payload' do
      payload = {
        email: user.email,
        userId: nil,
        eventName: event.title,
        id: event.id,
        createdAt: event.created_at.to_i,
        dataFields: {},
        campaignId: 0,
        templateId: 0,
        createNewFields: true
      }
      expect(api_service).to receive(:call).with(payload: payload)
      service.call
    end
  end

  describe '#generate_event_payload' do
    let(:user_event) { instance_double(UserEvent, event: event, user: user) }
    let(:event) { instance_double(Event, title: 'Test Event', id: 1, created_at: Time.now) }
    let(:user) { instance_double(User, email: 'test@example.com', id: 1) }
    let(:service) { described_class.new(user_event: user_event, api_service: nil) }

    it 'generates the event payload correctly' do
      payload = service.generate_event_payload
      expect(payload[:email]).to eq(user.email)
      expect(payload[:userId]).to eq(nil)
      expect(payload[:eventName]).to eq(event.title)
      expect(payload[:id]).to eq(event.id)
      expect(payload[:createdAt]).to eq(event.created_at.to_i)
      expect(payload[:dataFields]).to eq({})
      expect(payload[:campaignId]).to eq(0)
      expect(payload[:templateId]).to eq(0)
      expect(payload[:createNewFields]).to eq(true)
    end
  end
end
