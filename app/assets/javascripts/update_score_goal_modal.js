jQuery(document).on('page:load turbolinks:load', function() {
  $('#update_score_modal')
    .modal('attach events', "#update_score_btn", 'show')
    .modal({
      onHide: function(){$("#update_score_btn").removeClass('active')}
    })
  ;

  $('#update_goal_modal')
    .modal('attach events', "#update_goal_btn", 'show')
    .modal({
      onHide: function(){$("#update_goal_btn").removeClass('active')}
    })
  ;
});