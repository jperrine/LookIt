$().ready(function() {
	$('#flash').effect("highlight", {}, 3000);
	setTimeout(function() {
		$('#flash').fadeOut('fast');
	}, 2500);
    $.validator.messages.required = "";
    $('form').validate({ //uses validate plugin
        invalidHandler: function(e, validator) {
            var errors = validator.numberOfInvalids();
            if (errors) {
                var message = errors == 1
					? 'You missed 1 field. It has been highlighted below'
					: 'You missed ' + errors + ' fields.  They have been highlighted below';
                $("div.error span").html(message);
                $("div.error").show();
            } else {
                $("div.error").hide();
            }
        },
        onkeyup: false
    });
});