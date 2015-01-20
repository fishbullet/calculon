$( document ).ready(function() {
  // Accum value in input
  $(':button').click( function() {
    var vvar = $(this).val();
    var a_input = $("#answer").val();
    $("#answer").val(a_input + vvar);
  });

  // Sent value to the server
  $('#calculate').click( function() {
    var data = $("#answer").val();
    $("#answer").val('');
    $.post('/calculate', { input_value: data });
  });

  // Clear input
  $('#clean').click( function() {
    $("#answer").val('');
  });
});
