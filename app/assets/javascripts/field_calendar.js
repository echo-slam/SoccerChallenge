var initialize_calendar;
initialize_calendar = function() {
  $('.field-calendar').each(function(){
    var calendar = $(this);
    var current_path = window.location.pathname;
    calendar.fullCalendar({
      defaultView: 'agendaWeek',
      header: {
        left: '',
        center: 'title',
        right: ''
      },
      firstDay: 1,
      minTime: '06:00:00',
      defaultTimedEventDuration: '01:00:00',
      forceEventDuration: true,
      selectable: true,
      selectHelper: true,
      editable: true,
      eventLimit: true,
      eventOverlap: false,
      eventColor: 'green',
      events: current_path + '.json',

      eventClick: function(event, jsEvent, view) {
        $.getScript(event.edit_url, function() {
          $('#start-time').val(moment(event.start).format('YYYY-MM-DD HH:mm'));
          $('#end-time').val(moment(event.end).format('YYYY-MM-DD HH:mm'));
        });
      },

      eventRender: function(event, element, view) {
        if (event.changing) {
          console.log(event.end.format());
        }
      },

      eventResizeStart: function(event, jsEvent, ui, view) {
        event.changing = true;
      },

      eventResizeEnd: function(event, jsEvent, ui, view) {
        event.changing = false;
      },

      eventResize: function(event, delta, revertFunc) {
        console.log("end: " + event.end.format())
      },

      eventDragStart: function(event, jsEvent, ui, view) {
        event.changing = true;
      },

      eventDragEnd: function(event, jsEvent, ui, view) {
        event.changing = false;
      },

    });
  })
};

$(document).on('turbolinks:load', initialize_calendar)