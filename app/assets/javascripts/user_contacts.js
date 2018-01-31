$(function(){
  // Show hidden table row with user message by clicking on parent row
  $( '.clicked_row' ).click(function(){
    $hidden_row = $( this ).next(); 
    if(( $hidden_row ).hasClass('show_message_row')){
      $hidden_row.css("display", "none").removeClass('show_message_row');
    } else {
      $hidden_row.addClass('show_message_row').fadeIn(800);
    }
  });
  // Hide table row with message in case it was successfully deleted from DB
  $('.delete_contact').click(function(event){
    event.stopPropagation();
    var current_contact_tr = $( this ).parents('tr')[0]; 
    if(confirm("Are you sure?")){
      $.ajax({
        url: 'contacts/' + $(current_contact_tr).attr('data-contact-id'),
        type: 'POST',
        data: { _method: 'DELETE' },
        success: function(result){
          $(current_contact_tr).fadeOut(300);
        }
      });
    };
  });
});