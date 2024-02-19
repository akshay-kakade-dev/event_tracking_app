class UserEventCreateService
  def initialize(event_params:)
    @event_params = event_params
  end

  def call
    UserEvent.create!(user_id: event_params[:event_id], event_id: event_params[:user_id])
  end
end