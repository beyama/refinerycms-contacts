function contacts_initialize_tagarea(area) {
	var list   = form  = $('ul', area),
      form   = $('form', area);
  
  $('a.edit, a.cancel', area).click(function() {
    list.toggle();
    form.toggle();
    return false;
  });
  
  $('input[type=submit]', form).click(function() {
    $("<img src='/images/refinery/ajax-loader.gif' width='16' height='16' class='save-loader' />").appendTo($(this).parent()); 
  });
}

$(function() {
	
	var tagareas = $('.tagarea');
	if(tagareas.length > 0) {
		tagareas.each(function() {
			contacts_initialize_tagarea( $(this) );
		});
	}
	
});
