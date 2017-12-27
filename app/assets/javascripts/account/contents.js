function inititalize_content_category_select() {
  $('.content-category-selector').change(function(event){
    update_category($(event.target));
  });

  // helpers

  function update_category(category_select) {
    var url                 = category_select.data('filters-path');
    var klass               = category_select.data('klass');
    var content_category_id = category_select.find(':selected').val();

    $.ajax({
      url: url,
      dataType: 'script',
      data: {
        klass: klass,
        content_category_id: content_category_id
      }
    });
  };
};
