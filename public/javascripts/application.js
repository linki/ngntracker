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
  
  $("#ticket_portal_input").hide()
  $("#ticket_organizer_id").change(function() {
    container = $("#ticket_portal_id")
    template = "<option value='{id}'>{name}</option>"
    organizer_id = $(this).children('option:selected').val();
    if (organizer_id > 0) {
      $.getJSON("/portals.json?search[organizer_id]=" + organizer_id, function(entries) {
        container.html('<option></option>')
        $.each(entries, function(i, entry) {
          container.append($.nano(template, entry.portal))
        })
        $("#ticket_portal_input").show()
      });
    } else {
      $("#ticket_portal_input").hide();
    }
  });
});  