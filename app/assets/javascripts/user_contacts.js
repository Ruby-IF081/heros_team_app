$(function(){
  // Hide table row with message in case it was successfully deleted from DB
  $('.delete_contact').on("ajax:success", function(event){
      var current_tr = $( this ).parents('tr')[0];
      $(current_tr).next().hide().fadeOut(800)
      $(current_tr).fadeOut(800);
    }).on("ajax:error", function(){
      $('.error_message').replaceWith($("<h4 style='color: red;'>Error occurred , please refresh the page!</h4>"));
    });
    // Show hidden table row with user message by clicking on parent row
  $( '.clicked_row' ).click(function(){
    $hidden_row = $( this ).next(); 
    if(( $hidden_row ).hasClass('show_message_row')){
      $hidden_row.css("display", "none").removeClass('show_message_row');
    } else {
      $hidden_row.addClass('show_message_row').fadeIn(800);
    }
  });
});