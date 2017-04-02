var initialize_calendar;
var field_owner_calendar;

initialize_calendar = function() {
  $('.field-calendar').each(function(){
    var calendar = $(this);
    var current_path = window.location.pathname;
    calendar.fullCalendar({
      defaultView: 'agendaWeek',
      header: {
        left: '',
        center: 'title',
        right: 'next today'
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
      selectConstraint: {
        start: moment().subtract(1, 'hour'),
        end: moment().startOf('day').add(1, 'day')
      },
      eventConstraint: {
        start: moment().format('YYYY-MM-DD'),
      },
      events: {
        url: current_path + '.json',
      },

      eventClick: function(event, jsEvent, view) {
        if (event.host_id == event.viewer_id) {
          $.getScript(event.edit_url, function() {
            $('#start-time').val(moment(event.start).format('YYYY-MM-DD HH:mm'));
            $('#end-time').val(moment(event.end).format('YYYY-MM-DD HH:mm'));
          });
        }
      },

      eventRender: function(event, element, view) {
        if (event.host_id == event.viewer_id) {
          element.css('backgroundColor', 'green');
        } else {
          element.css('backgroundColor', 'red');
        }
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

field_owner_calendar = function() {
  $('.field-owner-calendar').each(function() {
    var calendar = $(this);
    calendar.fullCalendar({
      header: {
        left: 'prev,next today',
        center: '',
        right: 'month,agendaWeek,agendaDay'
      },
      firstDay: 1,
      minTime: '06:00:00',
      maxTime: '23:00:00',
      allDaySlot: false,
    });
  })
};

$(document).on('turbolinks:load', initialize_calendar, field_owner_calendar)