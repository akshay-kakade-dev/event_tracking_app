class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  private
  
  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header.present?
    begin
      decoded_token = JsonWebToken.decode(token)
      @current_user = User.find(decoded_token['user_id'])
    rescue JWT::DecodeError
      head :unauthorized
    end
  end
end
