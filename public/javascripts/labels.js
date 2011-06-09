
(function($) {

    // input wire-up
    $('input').live('keyup', active_field)
    .live('paste', active_field)
    .live('focusout', check_field)
    .live('focusin', active_field);

    // runs on page loading complete to adjust labels based on content
    $(function() {
        $('input').each(check_field);
    });

    // Currently being typed into
    function active_field(){
      var field = $(this).closest('.field');
      cleanup(field);
      if(field_is_empty(field)){  
        field.addClass('active_visible_label'); 
      }
      else {
        field.addClass('active_hidden_label');
      }
    };

    // to determine the status
    function check_field(){
      var field = $(this).closest('.field');
      if(field_is_empty(field)){
        empty_field(field);
      }
      else {
        full_field(field);
      }
    };

    // No chars, not being typed into
    function empty_field(field){
      cleanup(field);
      field.addClass('visible_label');
    };
    
    // One or more chars, previously typed into
    function full_field(field){
      cleanup(field);
      field.addClass('hidden_label');
    };

    // removes all the classes we add which modify the look of the field
    function cleanup(field){
      field.removeClass('visible_label hidden_label active_visible_label active_hidden_label');
    }

    // our determination of emptyness
    function field_is_empty(field){
      if(jQuery.trim(field.find('input').val()).length == 0){
        return true;
      }
      else { 
        return false;
      }
    }

})(jQuery);

