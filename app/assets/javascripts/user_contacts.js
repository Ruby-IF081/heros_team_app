// Show element with message from user by clicking on table row.
$(function(){
  $('.clicked_row').click(function(){
    $hidden_row = $(this).next(); 
    if($hidden_row.hasClass('show_message_row')){
      $hidden_row.css("display", "none").removeClass('show_message_row');
    } else {
      $hidden_row.addClass('show_message_row').fadeIn(800);
    }
  });
});