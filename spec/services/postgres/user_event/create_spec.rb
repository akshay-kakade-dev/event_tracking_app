# spec/services/postgres/user_event/create_spec.rb
require 'rails_helper'

RSpec.describe Postgres::UserEvent::Create do

  before {
    WebMock.stub_request(:post, "https://api.iterable.com/api/events/track")
      .to_return(status: 200, body: "{\"data\": \"mocked_response\"}", headers: {})

    WebMock.stub_request(:post, "https://api.iterable.com/api/email/target")
      .to_return(status: 200, body: "{\"data\": \"mocked_response\"}", headers: {})
  }

  describe '#call' do
    context 'when user event creation is successful' do
      let(:user) { User.create(name: Faker::Name.name, email: Faker::Internet.email) }
      let(:event) { Event.create(category: 'A', title: 'Event A') }
      
      let(:row_attrs) { { user_id: user.id, event_id: event.id } }
      let(:service) { described_class.new }

      it 'creates a user event and returns success response with event id' do
        result = service.call(row_attrs: row_attrs)
        expect(result[:success]).to eq(true)
        expect(result[:data][:id]).to be_present
      end
    end

    context 'when user event creation fails' do
      let(:row_attrs) { { user_id: nil, event_id: nil } }
      let(:service) { described_class.new }

      it 'does not create a user event and returns failure response with errors' do
        result = service.call(row_attrs: row_attrs)
        expect(result[:success]).to eq(false)
        expect(result[:errors]).to be_present
      end
    end
  end
end
