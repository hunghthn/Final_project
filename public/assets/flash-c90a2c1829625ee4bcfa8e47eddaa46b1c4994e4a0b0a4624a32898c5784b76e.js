// app/assets/javascripts/flash_messages.js
$(document).ready(function() {
    var $flashMessage = $('.flash-message');
  
    if ($flashMessage.length) {
      $(window).on('scroll', function() {
        $flashMessage.fadeOut();
      });
  
      // Optional: Set a timeout to automatically hide the flash message after a certain time
      setTimeout(function() {
        $flashMessage.fadeOut();
      }, 5000); // 5000 milliseconds = 5 seconds
    }
  });
  
