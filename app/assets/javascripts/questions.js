

$(document).on('ready', function() {

  $(document).on("click", "#ask-question-btn", function(event) {
    event.preventDefault();

    $(".content-wrapper #question-form").removeClass("hidden");
    $(this).hide();
  });
});
