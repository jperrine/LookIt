$(document).ready(function() {
	tinyMCE.init({
	  mode: 'textareas',
	  theme: 'advanced',
	  editor_selector: 'content',
		width: 565,
		height: 478,
		plugins: 'safari,media,autosave,advimage,preview,inlinepopups',
		theme_advanced_toolbar_location : "top",
		theme_advanced_buttons1: "bold,italic,underline,bullist,numlist,undo,redo,link,unlink,image,media,forecolor,blockquote,removeformat,code,media,preview",
	  theme_advanced_buttons2: "",
	  theme_advanced_buttons3: "",
	  entity_encoding: "raw",
	  dialog_type: "modal",
		content_css: "/stylesheets/tiny_mce.css",
	});
	
	//intercept form submit button click to copy contents of tinymce to the textarea for content
	$('form input:submit').click(function() {
		$('form input#page_content').val(getEditorContent());
	})
	//unbinds the look version of preview
	$('div#header ul li#preview').unbind('click');
	
	$('div#header ul li#preview').click(function() {
		$('div#header ul li#edit').removeClass('active');
		$(this).addClass('active');
		$('div#previewDisplay').empty();
		var HTML = "<h3>"+$('input:text.required').val()+"</h3><br /><div id='pageContent'>" + getEditorContent() + "</div>";
		$('div#previewDisplay').append(HTML);
		$('div#edit').slideUp('fast', function() {
			$('div#preview').slideDown('slow');
		});
	});
});

function getEditorContent() {
	return tinyMCE.activeEditor.getContent();
}