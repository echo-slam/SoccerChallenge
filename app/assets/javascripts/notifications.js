$(document).on('turbolinks:load', function() {
  $(".ui.inline.dropdown").dropdown();


  var ajax_call = function() {
    $.getJSON ("/notifications.json", function(data) {
      var notifications = data.notifications;
      var paths = data.paths;
      
      if (notifications.length != 0) {
        count = "<span class=\"ui red circular label\">" +
        notifications.length + "</span>";

        $("#notifications_count").html(count);
      }
      var notify_messages = "";
    
      $.each(notifications, function(key,val) {
        notify_messages += "<a class=\"item\" href=\"/notifications/" +
          val.id + "/link_through\">" +  val.notice_messages  +  "</a>" ;
      });

      $('.notifications').html(notify_messages);
    });
  };

  var interval = 5000; // 5 second
  // ajax_call();
  setInterval(ajax_call, interval)

}); 