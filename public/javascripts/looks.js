$().ready(function() {
	$('div#header ul li#preview').click(function() {
		$('div#header ul li#edit').removeClass('active');
		$(this).addClass('active');
	});
	
	$('div#header ul li#edit').click(function() {
		$('div#header ul li#preview').removeClass('active');
		$(this).addClass('active');
		$('div#preview').slideUp('fast', function() {
			$('div#edit').slideDown('slow');
		});
	});
	
	$('#previewSave').click(function() {
		var formID = $(this).parent().parent().find('form').attr('id');
		$('#'+formID).submit();
		if ($('#errorDiv span').html().length > 0) {
			$('div#header ul li#edit').click();
		}
	})
});