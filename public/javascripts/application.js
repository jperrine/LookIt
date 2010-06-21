$().ready(function() {
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
	$('input.watermarked').each(function() {
	  $(this).watermark('watermark', $(this).attr('title'));
	});
});