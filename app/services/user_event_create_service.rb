class UserEventCreateService

  attr_accessor :user_event

  def initialize(event_params:)
    @event_params = event_params
  end

  def call
    user_event = UserEvent.create!(user_id: event_params[:event_id], event_id: event_params[:user_id])

    if user_event.persisted?
      {
        success: true,
        data: {
          id: user_event.id
        }
      }
    else
      {
        success: false,
        errors: resource.errors
      }
    end
  end
end