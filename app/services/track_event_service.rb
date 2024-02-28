# generalised track event service, #irrespetive of it's adapter like iterabe
class TrackEventService 

  attr_reader :user_event, :api_service

  def initialize(user_event:, api_service:)
    @user_event = user_event
    @api_service = api_service
  end

  def call
    payload = generate_event_payload()
    api_service.call(payload: payload)
  end

  # generalise payload irrespective of service
  def generate_event_payload()
    event = @user_event.event
    user = @user_event.user

    {
      "email": user.email,
      "userId": nil, #needs id that is in iterable
      "eventName": event.title,
      "id": event.id,
      "createdAt": event.created_at.to_i,
      "dataFields": {},
      "campaignId": 0,
      "templateId": 0,
      "createNewFields": true
    }
  end
end