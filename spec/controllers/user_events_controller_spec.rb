# spec/controllers/user_events_controller_spec.rb
require 'rails_helper'

RSpec.describe UserEventsController, type: :controller do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:event) { create(:event) }
    let(:jwt_secret) { Rails.application.credentials.jwt_secret_key }
    let(:token) { JsonWebToken.encode({ user_id: user.id })}


    let(:valid_params) { { user_event: { event_id: event.id } } }
    let(:adapter_double) { instance_double(Postgres::UserEvent::Create) }
    let(:service_double) { instance_double(UserEventCreateService) }

    before do
      request.headers['Authorization'] = "#{token}"
    end

    context 'when user event creation is successful' do
      before do
        allow(Postgres::UserEvent::Create).to receive(:new).and_return(adapter_double)
        allow(UserEventCreateService).to receive(:new).and_return(service_double)
        allow(service_double).to receive(:call).and_return({ success: true, data: { id: 1 } })
      end

      it 'creates a user event and returns success response' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to eq({ "success" => true, "data" => { "id" => 1 } })
      end
    end

    context 'when user event creation fails' do
      before do
        allow(Postgres::UserEvent::Create).to receive(:new).and_return(adapter_double)
        allow(UserEventCreateService).to receive(:new).and_return(service_double)
        allow(service_double).to receive(:call).and_return({ success: false, errors: {} })
      end

      it 'returns unprocessable entity response' do
        post :create, params: valid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq({ "success" => false, "errors" => {} })
      end
    end
  end
end
