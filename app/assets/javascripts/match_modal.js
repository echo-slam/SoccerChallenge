$(document).on('page:ready turbolinks:load', function() {
  $('#available_teams_modal')
  .modal('attach events', '#available_teams_btn', 'show')
  .modal({
    onHide: function(){$("#available_teams_btn").removeClass('active')}
  });

  $('#match_requests_modal')
  .modal('attach events', '#match_requests_btn', 'show')
  .modal({
    onHide: function(){$("#match_requests_btn").removeClass('active')}
  });
});