# service to send actual email data to iterable
class Iterable::SendEmailToUserService
  attr_reader :payload
  
  def initialize()
  end

  def call(payload:)
    conn = Faraday.new(url: 'https://api.iterable.com/') do |faraday|
      # Set Faraday adapter, you can use different adapters based on your needs
      faraday.adapter Faraday.default_adapter
    end

    api_response = conn.post("api/email/target") do |request|
      request.headers['Content-Type'] = 'application/json'

      request.body = payload.to_json
    end

    json_response = JSON.parse(api_response.body) rescue { error: "Invalid JSON with response code: #{api_response.status}" }
    
    if api_response.status == 200
      {
        success: true,
        data: json_response
      }
    else
      {
        success: false,
        data: json_response
      }
    end
  end
end