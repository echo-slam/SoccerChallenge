$(document).on('turbolinks:load', function(){
  $('#datetimepicker').datetimepicker({
    timepicker: false,
    minDate: '0',
    format: 'M d, Y'
  });
});