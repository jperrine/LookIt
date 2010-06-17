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
		$('div#previewcontent #contentDisplay').empty();
		var HTML = "<h3>"+$('#look_title').val()+"</h3><p>"+$('#look_content').val()+"</p>";
		$('div#previewcontent #contentDisplay').append(HTML);
		$('div#editcontent').slideUp('fast', function() {
			$('div#previewcontent').slideDown('slow');
		});
	});
	$('div#editpreview span.edit').click(function() {
		$('div#editpreview span.preview').removeClass('activeTab');
		$(this).addClass('activeTab');
		$('div#previewcontent').slideUp('fast', function() {
			$('div#editcontent').slideDown('slow');
		});
	});
	
	$('#previewSave').click(function() {
		var formID = $(this).parent().parent().find('form').attr('id');
		$('#'+formID).submit();
		if ($('#errorDiv span').html().length > 0) {
			$('div#editpreview span.edit').click();
		}
	})
});