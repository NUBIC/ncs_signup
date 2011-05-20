
$(function() {

    function checkvalue(){
    //     alert($(this).val());       
    };

    // some wire up
    $('input, textarea').live('focusout', checkvalue);

    $('#confd_show').click(function(){
      $('#confd_msg').dialog({
			  modal: true,
			  buttons: {
				  Ok: function() {
					  $( this ).dialog( "close" );
			  	}
			  }
		  });
    });

});

