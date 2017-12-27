function initializeNavigationItemForm() {
  checkedRadio = $('.navigation_item_linked_to.radio_buttons input:checked');

  displayContainerForRadio(checkedRadio);

  $('input[type="radio"]').on('click', function(event){
    displayContainerForRadio(event.target);
  });

  $(".tree-multiselect").treeMultiselect({ searchable: true,
                                           startCollapsed: true,
                                           showSectionOnSelected: true });
};

// helpers

function displayContainerForRadio(radio) {
  $('#linked-to-associations > *').hide();
  container = $('#' + $(radio).val());
  container.show();
};
