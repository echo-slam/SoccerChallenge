$(document).on('turbolinks:load', function() {
  $(".ui.inline.dropdown").dropdown();
  get_notify_count();
  ajax_call();

  // ajax_call();
  var noti_1 = setInterval(get_notify_count, interval)
  var noti_2 = setInterval(ajax_call, interval)
});

jQuery(document).on('page:ready turbolinks:before-render', function() {
  clearInterval(noti_1);
  clearInterval(noti_2);
});

var interval = 10000; // 10 seconds


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

    console.log("notification count")
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

    console.log("ajax call")
  });
};