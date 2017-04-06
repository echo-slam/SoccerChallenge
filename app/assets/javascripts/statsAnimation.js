jQuery(document).on('page:ready turbolinks:load', function() {
  statsAnimate();
});

jQuery(document).on('page:ready turbolinks:before-visit', function() {
  $('#stat_1').transition('hide', 'complete');
  $('#stat_2').transition('hide', 'complete');
  $('#stat_3').transition('hide', 'complete');
  $('#team-chart-1').hide();
  $('#team-chart-2').hide();
  $('#team-chart-3').hide();
  $('#player-chart-1').hide();
  $('#player-chart-2').hide();
  $('#team-chart-1').finish();
  $('#team-chart-2').finish();
  $('#team-chart-3').finish();
  $('#player-chart-1').finish();
  $('#player-chart-2').finish();
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