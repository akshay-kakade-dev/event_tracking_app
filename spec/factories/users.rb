# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    # Define attributes for the user model
    # For example:
    email { Faker::Internet.email }
  end
end
