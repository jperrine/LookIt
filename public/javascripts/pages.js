$(document).ready(function() {
	//unbinds the look version of preview
	$('div#editpreview span.preview').unbind('click');
	
	$('div#editpreview span.preview').click(function() {
		$('div#editpreview span.edit').removeClass('activeTab');
		$(this).addClass('activeTab');
		$('div#previewcontent #contentDisplay').empty();
		var HTML = "<h3>"+$('#page_title').val()+"</h3>"+$('#page_content_ifr').contents().find('body').html();
		$('div#previewcontent #contentDisplay').append(HTML);
		$('div#editcontent').slideUp('fast', function() {
			$('div#previewcontent').slideDown('slow');
		});
	});
});