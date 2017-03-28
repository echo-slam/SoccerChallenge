jQuery(document).on('page:ready turbolinks:load', function() {
  $('#team_request_modal')
    .modal('attach events', "#team_request_btn", 'show')
    .modal({
      onHide: function(){$("#team_request_btn").removeClass('active')}
    })
  ;

  $('#match_invite_modal')
    .modal({
      onShow: function(){}
    })
    .modal('attach events', "#match_invite_btn", 'show')
    .modal({
      onHide: function(){$("#match_invite_btn").removeClass('active')}
    })
  ;
});