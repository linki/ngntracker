$(function($) {
  // show flash messages as growl-like gritter message
  $('#flash_notice, #flash_error').hide();
  $('#flash_notice, #flash_error').each(function() {
    $.gritter.add({
      // (string | mandatory) the heading of the notification
      title: 'Notice',
      // (string | mandatory) the text inside the notification
      text: $(this).html()
    });
  });
});