# app/models/user_event.rb
class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  after_create :call_api_if_event_type_b

  private

  # blog for choosing which client
  #https://www.scrapingdog.com/blog/ruby-http-clients/

  def call_api_if_event_type_b
    TrackEventService.new(user_event: self).call

    if event.event_type == 'B'
      SendEmailToUser.new(user_event: self).call
    end
  end
end
