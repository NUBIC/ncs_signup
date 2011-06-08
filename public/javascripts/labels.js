
(function($) {

    function showLabel(){
      var field = $(this).closest('.field');
      if(jQuery.trim($(this).val()).length == 0){ 
        field.find('label.overlabel').css('color', '#777777');
      }
      else{
        field.find('label.overlabel').css('color', '#FFFFFF');
      }
      field.css('background-color', '#FFFFFF');
    };

    function hideLabel(){
      var field = $(this).closest('.field');
      field.find('label.overlabel').css('color', field.css('background-color'));
    };

    $('input, textarea').live('keydown', hideLabel);
    $('input, textarea').live('paste', hideLabel);
    $('input, textarea').live('focusout', showLabel);

    //Gray it out when in focus
    $('input, textarea').live('focusin', function() {
        
     if(jQuery.trim($(this).val()).length == 0){ 
        var field = $(this).closest('.field')
        field.find('label.overlabel').css('color', '#333333');
        field.css('background-color', '#E5E686');
      }
      else{
        var field = $(this).closest('.field');
        field.find('label.overlabel').css('color', field.css('background-color'));
      }
    });

    // runs on page loading complete to adjust labels based on content
    $(function() {
        $('input, textarea').each(showLabel);
    });

})(jQuery);

