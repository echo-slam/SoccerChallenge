jQuery(document).on('page:ready turbolinks:load', function() {
  $('#invitation_modal')
    .modal('attach events', "#invitation_btn", 'show')
    .modal({
      onHide: function(){$("#invitation_btn").removeClass('active')}
    })
  ;
});