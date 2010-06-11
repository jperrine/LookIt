$(document).bind('click', function(e) {
    var $clicked = $(e.target);
    if (! $clicked.parents().hasClass("pageSelect"))
        $(".pageSelect dd ul").slideUp();
});
$().ready(function() {
	$('.pageSelect span').click(function() {
		$('.pageSelect dd ul').slideToggle();
	});
});