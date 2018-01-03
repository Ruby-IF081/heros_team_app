(function(window, document, $) {
  
  'use strict';

  $.app= $.app || {};

  $.app.menu= {
    change: function() {
      $('body[data-open="hover"] .dropdown').on('mouseenter', function(){
        if (!($(this).hasClass('open'))) {
          $(this).addClass('open');
        }else{
          $(this).removeClass('open');
        }
        }).on('mouseleave', function(){
          $(this).removeClass('open');
        });
    },
  };
})(window, document, jQuery);

$(window).on('load',function(){
   $.app.menu.change();
});