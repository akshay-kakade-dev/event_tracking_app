# spec/services/iterable/send_email_to_user_service_spec.rb
require 'rails_helper'
require 'webmock/rspec'

RSpec.describe Iterable::SendEmailToUserService do
  describe '#call' do
    let(:service) { described_class.new }

    before do
      stub_request(:post, "https://api.iterable.com/api/email/target")
        .with(
          headers: {
            'Content-Type' => 'application/json'
          },
          body: {
            subject: "Test Subject",
            body: "Test Body",
            recipient_email: "test@example.com"
          }.to_json
        )
        .to_return(status: status, body: response_body.to_json)
    end

    context 'when the API call is successful' do
      let(:status) { 200 }
      let(:response_body) { { "success" => true } }
      let(:payload) { { subject: "Test Subject", body: "Test Body", recipient_email: "test@example.com" } }

      it 'returns success response with data' do
        result = service.call(payload: payload)
        expect(result).to eq(success: true, data: response_body)
      end
    end

    context 'when the API call fails' do
      let(:status) { 400 }
      let(:response_body) { { "error" => "Bad Request" } }
      let(:payload) { { subject: "Test Subject", body: "Test Body", recipient_email: "test@example.com" } }

      it 'returns failure response with error data' do
        result = service.call(payload: payload)
        expect(result).to eq(success: false, data: response_body)
      end
    end
  end
end
