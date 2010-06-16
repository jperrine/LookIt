$(document).ready(function() {
	$('div#editpreview span.preview').unbind('click');
	
	$('div#editpreview span.preview').click(function() {
		$('div#editpreview span.edit').removeClass('activeTab');
		$(this).addClass('activeTab');
		$('div#editcontent').hide();
		$('div#previewcontent').empty();
		var HTML = "<h3>"+$('#page_title').val()+"</h3><p>"+$('#page_content').val()+"</p>";
		$('div#previewcontent').append(HTML);
		$('div#previewcontent').show();
	});
});