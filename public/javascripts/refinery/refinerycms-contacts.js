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
	
	// contact new/edit
	if($('#contact-form').length > 0) {
	  page_options.init(false, '', '');
	  
	  var is_organisation = $('#contact_is_organisation'),
        only_natural = $('.only-natural-person'),
        organisation_context = $('.organisation_context');
    
    function switch_organisation_context() {
      if(is_organisation.attr('checked')) {
        only_natural.hide();
        organisation_context.each(function() {
          var el = $(this);
          el.text(el.attr('organisation_title'));
        });
      } else {
        only_natural.show();
        organisation_context.each(function() {
          var el = $(this);
          el.text(el.attr('natural_title'));
        });
      }
    }
    is_organisation.click(switch_organisation_context);
    
    switch_organisation_context();
	}
	
	// contact show
	if($('#contact').length > 0) {
	 var container = $('#contact_background');
    $('#contact_background_button').click(function(){
      container.toggle();
      return false;
    });
	}
});
