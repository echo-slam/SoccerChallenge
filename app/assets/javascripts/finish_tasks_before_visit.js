jQuery(document).on('page:ready turbolinks:before-visit', function() {
  $("div").finish();
  Turbolinks.clearCache()
});