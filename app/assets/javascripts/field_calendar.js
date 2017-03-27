var initialize_calendar;
initialize_calendar = function() {
  $('.field-calendar').each(function(){
    var calendar = $(this);
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
      events: '/matches.json',

      eventClick: function(event, jsEvent, view) {
        $.getScript(event.edit_url, function() {
          $('#start-time').val(moment(event.start).format('YYYY-MM-DD HH:mm'));
          $('#end-time').val(moment(event.end).format('YYYY-MM-DD HH:mm'));
        });
      },

      eventResize: function(event, delta, revertFunc) {
        event.end.format();
      },

    });
  })
};

$(document).on('turbolinks:load', initialize_calendar)