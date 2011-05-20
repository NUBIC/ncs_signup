
(function($) {

    function showLabel(){
      if(jQuery.trim($(this).val()).length == 0){ 
        $(this).prev('label.overlabel').css('color', '#999');
      }
      else{
        // keep hidden cause there's stuff in it
        $(this).prev('label.overlabel').css('color', '#fff');
      }
    };

    function hideLabel(){
      $(this).prev('label.overlabel').css('color', '#fff');
    };

    //$('select').live('change', toggleLabel);

    $('input, textarea').live('keydown', hideLabel);
    $('input, textarea').live('paste', hideLabel);
    $('input, textarea').live('focusout', showLabel);

    //Gray it out when in focus
    $('input, textarea').live('focusin', function() {
        
     if(jQuery.trim($(this).val()).length == 0){ 
        $(this).prev('label.overlabel').css('color', '#ccc');
      }
      else{
        // keep hidden cause there's stuff in it
        $(this).prev('label.overlabel').css('color', '#fff');
      }

    });

    $(function() {
        $('input, textarea').each(showLabel);
    });

})(jQuery);

