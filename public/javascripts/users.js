$().ready(function() {
	$('#user_username').change(function() {
		$.get('/user/check_username', { username: $('#user_username').val() } , function(data) {
			if (data == 'false') {
				$('#username_error').text('Username is already taken; please chose another.');				
			} else {
				$('#username_error').empty();
			}
		});
	});
});