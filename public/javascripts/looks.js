$(document).bind('click', function(e) {
    var $clicked = $(e.target);
    if (! $clicked.parents().hasClass("pageSelect"))
        $(".pageSelect dd ul").slideUp();
});
$().ready(function() {
	$('#PageSelector dl.pageSelect span').click(function() {
		$('.pageSelect dd ul').slideToggle();
	});
	$('div#previewcontent').hide();
	$('div#editpreview span.preview').click(function() {
		$('div#editpreview span.edit').removeClass('activeTab');
		$(this).addClass('activeTab');
		$('div#editcontent').hide();
		$('div#previewcontent').empty();
		var HTML = "<h3>"+$('#look_title').val()+"</h3><p>"+$('#look_content').val()+"</p>";
		$('div#previewcontent').append(HTML);
		$('div#previewcontent').show();
	});
	$('div#editpreview span.edit').click(function() {
		$('div#editpreview span.preview').removeClass('activeTab');
		$(this).addClass('activeTab');
		$('div#previewcontent').hide();
		$('div#editcontent').show();
	});
});