# spec/factories/events.rb
FactoryBot.define do
  factory :event do
    # Define attributes for the event model
    # For example:
    title { Faker::Lorem.sentence }
    category { ['A', 'B'].sample }
    # Add more attributes as needed
  end
end