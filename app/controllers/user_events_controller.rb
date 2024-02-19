class UserEventsController < ApplicationController

  def create
    service = UserEventCreateService(event_params: event_params)
    service.call
  end

  protected
  
  def event_params
    params.require(:user_event).permit(:type, :user_id, :event_id)
  end
end
