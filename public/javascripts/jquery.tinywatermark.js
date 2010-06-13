(function($) {
	$.fn.watermark = function(css, text) {
		return this.each(function() {
			var i = $(this), w;
			i.focus(function() {
				w && !(w=0) && i.removeClass(css).data('w',0).val('');
			})
			.blur(function() {
				!i.val() && (w=1) && i.addClass(css).data('w',1).val(text);
			})
			.closest('form').submit(function() {
				w && i.val('');
			});
			i.blur();
		});
	};
	$.fn.removeWatermark = function() {
		return this.each(function() {
			$(this).data('w') && $(this).val('');
		});
	};
})(jQuery);