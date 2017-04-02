var field_owner_calendar;

field_owner_calendar = function() {
  $('.field-owner-calendar').each(function() {
    var calendar = $(this);
    var current_path = window.location.pathname;
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
      eventColor: '#009999',
      events: {
        url: current_path + '.json',
      },
    });
  })
};

$(document).on('turbolinks:load', field_owner_calendar)