$(function(){ 
  $("#new_contact").on("ajax:error", function(event) {
    remove_errors();
    var detail = event.detail;
    var xhr = detail[2];
    var errors = $.parseJSON(xhr.responseText).errors;
    for (i = 0; i < errors.length; i++){
      $('#errors ul').append('<li>' + errors[i] + '</li>');
    }
  }).on("ajax:success", function(){
    remove_errors();
  });  
});

function remove_errors(){
  $('#errors ul li').remove();
}
