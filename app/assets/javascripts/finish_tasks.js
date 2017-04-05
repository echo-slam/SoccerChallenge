jQuery(document).on('page:ready turbolinks:before-render', function() {
  clearInterval(interval_1);
  clearInterval(interval_2);
  clearInterval(team_mes);
  clearInterval(player_mes);
  Turbolinks.clearCache();
});
