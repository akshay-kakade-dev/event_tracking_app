# app/models/user_event.rb
class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  after_create :sync_events

  private

  # blog for choosing which client
  #https://www.scrapingdog.com/blog/ruby-http-clients/

  def sync_events
    iterable_service = Iterable::TrackEventService.new
    TrackEventService.new(user_event: self, api_service: iterable_service).call

    if event.category == 'B'
      iterable_service = Iterable::SendEmailToUserService.new
      SendEmailToUser.new(user_event: self, api_service: iterable_service).call
    end
  end
end
