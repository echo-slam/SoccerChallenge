$(document).on('turbolinks:load', function(){
  $('#start-time, #end-time').datetimepicker({
    minDate: '0',
    formatDate: 'M d, Y',
    formatTime: 'H:i'
  });
});