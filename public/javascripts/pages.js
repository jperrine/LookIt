$(document).ready(function() {
	//unbinds the look version of preview
	$('div#editpreview span.preview').unbind('click');
	
	$('div#editpreview span.preview').click(function() {
		$('div#editpreview span.edit').removeClass('activeTab');
		$(this).addClass('activeTab');
		$('div#previewcontent #contentDisplay').empty();
		var HTML = "<h3>"+$('#page_title').val()+"</h3>"+$('#page_content_ifr').contents().find('body').html();
		$('div#previewcontent #contentDisplay').append(HTML);
		$('div#previewcontent #contentDisplay img').each(function() {
			if ($(this).attr('class').length > 0) {
				var type = $(this).attr('class').replace('mceItem', '');
				$(buildMediaPlayer(type)).insertAfter($(this));
				$(this).remove();
			}
		});
		$('div#editcontent').slideUp('fast', function() {
			$('div#previewcontent').slideDown('slow');
		});
	});
});
//pulls the media url from the tinymce generated image
function getMediaURL(type) {
	var url = '';
	if (type == 'Flash') {
		url = $('div#previewcontent img.mceItem' + type).attr('title').split("\":\"")[3].split("\",\"")[0].replace("\\\"", '');
	} else if (type == 'QuickTime') {
		url = $('div#previewcontent img.mceItem' + type).attr('title').split(":'")[1].split(',')[0];
	} else if (type == 'WindowsMedia') {
		url = $('div#previewcontent img.mceItem' + type).attr('title').split(":'")[1].split(",")[0];
	} else if (type == 'RealMedia') {
		url = $('div#previewcontent img.mceItem' + type).attr('title').split(":'")[1].split(",")[0];
	} else if (type == 'ShockWave') {
		url = $('div#previewcontent img.mceItem' + type).attr('title').split(":'")[5].split(',')[0];
	}
	//alert(url);
	return url;
}
//gets the tinymce generated height from the user specified embed object
function getHeight(type) {
	return $('#contentDisplay img.mceItem' + type).attr('height');
}
//gets the tinymce generated width from the user specified embed object
function getWidth(type) {
	return $('#contentDisplay img.mceItem' + type).attr('width');
}
//builds the object embed code HTML for injection in the preview div
function buildMediaPlayer(type) {
	var URL = getMediaURL(type);
	var height = getHeight(type);
	var width = getWidth(type);
	var HTML = '';
	if (type == "Flash") {
		HTML = "<object width='"+width+"' height='"+height+"'>";
		HTML += "<param name='movie' value='"+URL+"'>";
		HTML += "</param><param name='allowFullScreen' value='true'></param>";
		HTML += "<param name='allowscriptaccess' value='always'></param>";
		HTML += "<embed src='"+URL+"' type='application/x-shockwave-flash' allowscriptaccess='always' allowfullscreen='true' width='"+width+"' height='"+height+"'>";
		HTML += "</embed></object>";
	} else if (type == 'QuickTime') {
		HTML = "<object width='"+width+"' height='"+height+"' codebase='http://www.apple.com/qtactivex/qtplugin.cab#version=6,0,2,0' classid='clsid:02bf25d5-8c17-4b23-bc80-d3488abddc6b'>";
		HTML += "<param value='"+URL+"' name='src'>";
		HTML += "<embed width='"+width+"' height='"+height+"' src='"+URL+"' type='video/quicktime'>";
		HTML += "</object>";
	} else if (type == 'WindowsMedia') {
		HTML = "<object width='"+width+"' height='"+height+"' codebase='http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701' classid='clsid:6bf52a52-394a-11d3-b153-00c04f79faa6'>";
		HTML += "<embed width='"+width+"' height='"+URL+"' type='application/x-mplayer2'>";
		HTML += "</object>";
	} else if (type == 'RealMedia') {
		HTML = "<object width='"+width+"' height='"+height+"' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0' classid='clsid:cfcdaa03-8be4-11cf-b84b-0020afbbccfa'>";
		HTML += "<embed width='"+width+"' height='"+height+"' type='audio/x-pn-realaudio-plugin'>";
		HTML += "</object>";
	} else if (type == 'ShockWave') {
		HTML = "<object width='"+width+"' height='"+height+"' codebase='http://download.macromedia.com/pub/shockwave/cabs/director/sw.cab#version=8,5,1,0' classid='clsid:166b1bca-3f9c-11cf-8075-444553540000'>";
		HTML += "<param value='true' name='sound'>";
		HTML += "<param value='true' name='progress'>";
		HTML += "<param value='true' name='autostart'>";
		HTML += "<param value='false' name='swliveconnect'>";
		HTML += "<param value='none' name='swstretchstyle'>";
		HTML += "<param value='none' name='swstretchhalign'>";
		HTML += "<param value='none' name='swstretchvalign'>";
		HTML += "<embed width='"+width+"' height='"+height+"' sound='true' progress='true' autostart='true' swliveconnect='false' swstretchstyle='none' swstretchhalign='none' swstretchvalign='none' type='application/x-director'>";
		HTML += "</object>";
	}
	return HTML;
}