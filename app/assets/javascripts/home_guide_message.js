jQuery(document).on('page:ready turbolinks:load', function() {
  guideAnimate();
});

jQuery(document).on('page:ready turbolinks:before-visit', function() {
  $('#guide-message').transition('hide', 'complete');
});

function guideAnimate() {
  $('#guide-message').transition({
    animation : 'scale in',
    duration  : '1s',
    onComplete : function() {
      $('#guide-message').removeClass('invi');
    }
  })
}