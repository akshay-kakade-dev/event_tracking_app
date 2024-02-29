require 'rails_helper'
require 'timecop'

RSpec.describe SendEmailToUser do
  let(:current_time) { Time.now }
  let(:user) { create(:user, email: 'user@example.com') }
  let(:event) { create(:event, category: 'B') }
  let(:user_event) { create(:user_event, user: user, event: event) }
  let(:api_service_double) { instance_double(Iterable::SendEmailToUserService) }
  let(:service) { described_class.new(user_event: user_event, api_service: api_service_double) }


  before do
    # Freeze time to a specific point
    Timecop.freeze(current_time)
  end

  after do
    # Unfreeze time after each test
    Timecop.return
  end


  describe '#call' do
    let(:payload) { { campaignId: 10, recipientEmail: user.email, recipientUserId: '', dataFields: {}, sendAt: DateTime.now.utc, allowRepeatMarketingSends: true, metadata: {} } }

    it 'calls the api_service with the correct payload' do
      expect(api_service_double).to receive(:call).with(payload: payload)
      service.call
    end
  end

  describe '#generate_event_payload' do
    it 'generates the event payload with the correct data' do
      expected_payload = {
        "campaignId": 10,
        "recipientEmail": user.email,
        "recipientUserId": "",
        "dataFields": {},
        "sendAt": DateTime.now.utc, # Adjust as needed
        "allowRepeatMarketingSends": true,
        "metadata": {}
      }
      expect(service.generate_event_payload).to eq(expected_payload)
    end
  end
end
