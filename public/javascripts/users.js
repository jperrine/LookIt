$().ready(function() {
	$('#user_username').change(function() {
		$.get('/user/check_username', { username: $('#user_username').val() } , function(data) {
			$('#username_error').text(data);
		});
	});
});