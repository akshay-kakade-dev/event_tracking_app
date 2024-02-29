# config/initializers/webmock.rb
require 'webmock'

if Rails.env.development? || Rails.env.test?
  WebMock.enable!
  
  # Define your mocks here

  WebMock.stub_request(:post, "https://api.iterable.com/api/events/track")
  .to_return(status: 200, body: "{\"data\": \"mocked_response\"}", headers: {})

  WebMock.stub_request(:post, "https://api.iterable.com/api/email/target")
         .to_return(status: 200, body: "{\"data\": \"mocked_response\"}", headers: {})
end
