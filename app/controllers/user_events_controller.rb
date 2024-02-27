class UserEventsController < ApplicationController

  def create
    # use adapater to change the implementation in future
    adapter = Postgres::UserEvent::Create.new
    service = UserEventCreateService.new(event_params: event_params, adapter: adapter)
    result = service.call

    if result[:success] == true
      render json: { success: true, data: result[:data] }, status: :created
    else
      render json: { success: false, errors: resource.errors }, status: :unprocessable_entity
    end
  end

  protected
  
  def event_params
    params.require(:user_event).permit(:user_id, :event_id)
  end
end
