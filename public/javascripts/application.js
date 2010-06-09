$().ready(function() {
	$.addwatermarks();
	$('#flash').effect("highlight", {}, 3000);
	setTimeout(function() {$('#flash').fadeOut('fast');}, 2500);
});