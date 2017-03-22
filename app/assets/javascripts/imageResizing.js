jQuery(document).on('page:change turbolinks:load', function() {
  setupImageResizing()
});

function setupImageResizing() {
  $( ".four-three-image" ).ready(function() {
    console.log("Image is ready");
    resizeIfNeeded()
  });
}

function resizeIfNeeded() {
  $(".four-three-image").map(function() {
    $(this).height(0.75 * $(this).width())
  });
}