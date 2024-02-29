require 'rails_helper'

RSpec.describe JsonWebToken do
  let(:payload) { { "user_id" => 123 } }

  describe '.encode' do
    it 'encodes the payload into a JWT token' do
      token = described_class.encode(payload)
      expect(token).not_to be_nil
    end
  end

  describe '.decode' do
    let(:token) { JsonWebToken.encode(payload) }

    context 'when the token is valid' do
      it 'decodes the token and returns the payload' do
        decoded_payload = described_class.decode(token)
        expect(decoded_payload).to eq(payload)
      end
    end

    context 'when the token is invalid' do
      it 'returns nil' do
        invalid_token = 'invalid_token'
        decoded_payload = described_class.decode(invalid_token)
        expect(decoded_payload).to be_nil
      end
    end
  end
end
