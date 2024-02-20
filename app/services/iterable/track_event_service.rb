class Iterable::TrackEventService
  attr_reader :payload
  
  def initialize(payload: payload)
    @payload = payload  
  end

  def call
    
  end
end