class EventsController < ApplicationController

  def create
    service = EventCreateService(event_params: event_params)
    service.call
  end

  protected
  
  def event_params
    params.require(:event).permit(:type)
  end
end
