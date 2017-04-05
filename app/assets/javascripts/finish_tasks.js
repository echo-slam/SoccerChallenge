jQuery(document).on('page:ready turbolinks:before-render', function() {
  clearInterval(interval_1);
  clearInterval(interval_2);
});