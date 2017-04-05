jQuery(document).on('page:ready turbolinks:before-render', function() {
  clearInterval(interval_1);
  clearInterval(interval_2);
});

function reload() {
  $.get("<%= match_match_messages_path(@match, format: :js) %>", function(response) {
    console.log("Reload match messages successfully", response)
  });
}

function reloadAway() {
  $.get("<%= away_match_path(@match, format: :js) %>", function(response) {
    console.log("Reload away team successfully", response)
  })
}