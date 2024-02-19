import { Application } from "@hotwired/stimulus"

import './jquery/dist/jquery'; // Use absolute path

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

$('.api-call-button').on('click', function(e) {
  e.preventDefault(); // Prevent the default form submission

  debugger
  var url = '/user_events'; // Get the URL from the button's href attribute
  var eventId = $(this).data('event-id');

  var payloadData = {
    user_id: '1',
    event_id: eventId
    // Add more key-value pairs as needed
  };

  // Make the AJAX request
  $.ajax({
    url: url,
    type: 'POST',
    data: payloadData,
    success: function(response) {
      // Handle the successful response
      console.log(response);
    },
    error: function(xhr) {
      // Handle errors
      console.error(xhr.responseText);
    }
  });
});
