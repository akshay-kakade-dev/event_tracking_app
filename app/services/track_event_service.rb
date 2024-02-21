class TrackEventService 

  attr_reader :user_event

  def initialize(user_event:)
    @user_event = user_event
  end

  def call
    payload = generate_event_payload()
    Iterable::TrackEventService.new(payload: payload).call
  end

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