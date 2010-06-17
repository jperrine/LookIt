$(document).ready(function() {
	//unbinds the look version of preview
	$('div#editpreview span.preview').unbind('click');
	
	$('div#editpreview span.preview').click(function() {
		$('div#editpreview span.edit').removeClass('activeTab');
		$(this).addClass('activeTab');
		$('div#editcontent').hide();
		$('div#previewcontent').empty();
		var HTML = "<h3>"+$('#look_title').val()+"</h3>"+$('#page_content_ifr').contents().find('body').html();
		$('div#previewcontent').append(HTML);
		$('div#previewcontent').show();
	});
});