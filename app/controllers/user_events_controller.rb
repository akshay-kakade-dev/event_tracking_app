class UserEventsController < ApplicationController
  before_action :authenticate_request


  def create
    # use adapater to change the implementation in future
    adapter = Postgres::UserEvent::Create.new
    service = UserEventCreateService.new(event_params: event_params.merge(user_id: @current_user.id), adapter: adapter)
    result = service.call

    if result[:success] == true
      render json: { success: true, data: result[:data] }, status: :created
    else
      render json: { success: false, errors: result[:errors] }, status: :unprocessable_entity
    end
  end

  protected
  
  def event_params
    params.require(:user_event).permit(:event_id)
  end
end
