# app/models/user_event.rb
class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  after_create :call_api_if_event_type_b

  private

  def call_api_if_event_type_b
    if event.event_type == 'B'
      
    end
  end
end
