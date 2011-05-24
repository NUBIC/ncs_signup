
(function($) {

    function showLabel(){
      if(jQuery.trim($(this).val()).length == 0){ 
        $(this).closest('.field').find('label.overlabel').css('color', '#999');
      }
      else{
        var field = $(this).closest('.field');
        field.find('label.overlabel').css('color', field.css('background-color'));
      }
    };

    function hideLabel(){
      var field = $(this).closest('.field');
      field.find('label.overlabel').css('color', field.css('background-color'));
    };

    //$('select').live('change', toggleLabel);

    $('input, textarea').live('keydown', hideLabel);
    $('input, textarea').live('paste', hideLabel);
    $('input, textarea').live('focusout', showLabel);

    //Gray it out when in focus
    $('input, textarea').live('focusin', function() {
        
     if(jQuery.trim($(this).val()).length == 0){ 
        $(this).closest('.field').find('label.overlabel').css('color', '#ccc');
      }
      else{
        var field = $(this).closest('.field');
        field.find('label.overlabel').css('color', field.css('background-color'));
      }

    });

    $(function() {
        $('input, textarea').each(showLabel);
    });

})(jQuery);

