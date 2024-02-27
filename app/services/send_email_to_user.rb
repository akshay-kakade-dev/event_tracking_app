class SendEmailToUser 

  attr_reader :user_event

  def initialize(user_event:, api_service:)
    @user_event = user_event
  end

  def call
    payload = generate_event_payload()
    api_service.call(payload: payload)
  end

  def generate_event_payload()
    user = @user_event.user

    {
      "campaignId": 10,
      "recipientEmail": user.email,
      "recipientUserId": "",
      "dataFields": {},
      "sendAt": DateTime.now.utc,
      "allowRepeatMarketingSends": true,
      "metadata": {}
    }
  end
end