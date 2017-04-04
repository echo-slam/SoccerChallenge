jQuery(document).on('page:ready turbolinks:load', function() {
  $('#sign_in_modal')
    .modal('attach events', "#sign_in_btn", 'show')
    .modal({
      onHide: function(){$("#sign_in_btn").removeClass('active')}
    })
  ;
});