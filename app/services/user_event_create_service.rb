class UserEventCreateService

  attr_accessor :event_params, :adapter

  def initialize(event_params:, adapter:)
    @event_params = event_params
    @adapter = adapter
  end

  def call
    adapter.call(row_attrs: event_params)
  end
end