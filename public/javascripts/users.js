$().ready(function() {
	$('#user_username').change(function() {
		$.get('/user/check_username', { username: $('#user_username').val() } , function(data) {
			if (data == 'false') {
				$('#username_error').text('Username is already taken.');
				$('#username_error').show();				
			} else {
				$('#username_error').hide();
				$('#username_error').empty();
			}
		});
	});
});