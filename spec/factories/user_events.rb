# spec/factories/events.rb
FactoryBot.define do
  factory :user_event do
    # Define attributes for the event model
    # For example:
    association :user
    association :event
  end
end