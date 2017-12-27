function initializeWidgetSorting(selector) {
  $(selector).sortable({
    axis: 'y',
    update: function() {
      $.post($(this).data('update-url'), $(this).sortable('serialize'));
    }
  })
};
