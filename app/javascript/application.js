// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


// app/assets/javascripts/application.js
$(document).on('turbolinks:load', function() {
  $('.api-call-button').on('click', function(e) {
    e.preventDefault(); // Prevent the default form submission

    var url = $(this).attr('href'); // Get the URL from the button's href attribute

    // Make the AJAX request
    $.ajax({
      url: url,
      type: 'GET',
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
});
