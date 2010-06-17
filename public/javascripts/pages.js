$(document).ready(function() {
	//unbinds the look version of preview
	$('div#editpreview span.preview').unbind('click');
	
	$('div#editpreview span.preview').click(function() {
		$('div#editpreview span.edit').removeClass('activeTab');
		$(this).addClass('activeTab');
		$('div#previewcontent #contentDisplay').empty();
		var HTML = "<h3>"+$('#page_title').val()+"</h3>"+$('#page_content_ifr').contents().find('body').html();
		$('div#previewcontent #contentDisplay').append(HTML);
		$('div#previewcontent #contentDisplay img.mceItemFlash').each(function() {
			$(buildYoutubePlayer()).insertAfter($(this));
			$(this).remove();
		});
		$('div#editcontent').slideUp('fast', function() {
			$('div#previewcontent').slideDown('slow');
		});
	});
});

function getFlashURL() {
	return $('#contentDisplay img.mceItemFlash').attr('title').split("\":\"")[1].split(',')[0];
}
function getHeight() {
	return $('#contentDisplay img.mceItemFlash').attr('height');
}
function getWidth() {
	return $('#contentDisplay img.mceItemFlash').attr('width');
}

function buildYoutubePlayer() {
	var URL = getFlashURL();
	var height = getHeight();
	var width = getWidth();
	var HTML = "<object width='"+width+"' height='"+height+"'>";
	HTML += "<param name='movie' value='"+URL+"'>";
	HTML += "</param><param name='allowFullScreen' value='true'></param>";
	HTML += "<param name='allowscriptaccess' value='always'></param>";
	HTML += "<embed src='"+URL+"' type='application/x-shockwave-flash' allowscriptaccess='always' allowfullscreen='true' width='"+width+"' height='"+height+"'>";
	HTML += "</embed></object>";
	return HTML;
}