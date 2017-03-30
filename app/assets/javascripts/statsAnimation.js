jQuery(document).on('page:ready turbolinks:load', function() {
  statsAnimate();
});

jQuery(document).on('page:ready turbolinks:before-visit', function() {
  $('#stat_1').transition('hide', 'complete');
  $('#stat_2').transition('hide', 'complete');
  $('#stat_3').transition('hide', 'complete');
});

function statsAnimate() {
  $('#stat_1').transition({
    animation : 'scale in',
    duration  : '500ms',
    onComplete : function() {
      $('#stat_1').removeClass('invi');
      $('#stat_2').transition({
        animation : 'horizontal flip in',
        duration  : '500ms',
        onComplete : function() {
          $('#stat_2').removeClass('invi');
          $('#stat_3').transition({
            animation : 'vertical flip in',
            duration  : '500ms',
            onComplete : function() {
              $('#stat_3').removeClass('invi');
            }
          })
        }
      })
    }
  })
};