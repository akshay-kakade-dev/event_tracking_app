# app/models/user_event.rb
class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  after_create :sync_events

  private

  # blog for choosing which client
  #https://www.scrapingdog.com/blog/ruby-http-clients/

  def sync_events
    TrackEventService.new(user_event: self).call

    if event.category == 'B'
      SendEmailToUser.new(user_event: self).call
    end
  end
end
