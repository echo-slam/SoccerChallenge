$(document).on('page:ready turbolinks:load', function() {
  $('#available_teams').on(function() {
    $.getScript(this.href);
    return false;
  });

  $('#available_teams_search input').keyup(function(response) {
    console.log("I am typing: ", response);
    $.get($('#available_teams_search').attr('action'), $('#available_teams_search').serialize(), null, 'script');
    return false;
  });
});