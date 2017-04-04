$(document).on('turbolinks:load', function() {
  $(".ui.inline.dropdown").dropdown();

  var get_notify_count = function() {
    $.getJSON ("/notifications.json", function(data) {
      var notifications = data.notifications;
      var paths = data.paths;
      
      if (notifications.length != 0) {
        count = notifications.length;

        $("#notifications_count").addClass("ui red circular label");
        $("#notifications_count").html(count);
      } else {
        $("#notifications_count").removeClass("ui red circular label");
        $("#notifications_count").html("");
      }
    });
  };

  var ajax_call = function() {
    $.getJSON ("/notifications.json", function(data) {
      var notifications = data.notifications;
      var paths = data.paths;

      var notify_messages = "";
    
      $.each(notifications, function(key,val) {
        notify_messages += "<a class=\"ui item\" href=\"/notifications/" +
          val.id + "/link_through\">" +  val.notice_messages  +  "</a>" ;
      });

      $('#notifications').html(notify_messages);
    });
  };

  var interval = 1000; // 1 second
  // ajax_call();
  setInterval(get_notify_count, interval)
  setInterval(ajax_call, interval)


}); 