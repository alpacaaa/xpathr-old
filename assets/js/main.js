
(function($) {
	$(document).ready(function(){

		var workspace = $("head link[rel='workspace']").attr('href');

		var editor = CodeMirror.fromTextArea('snippet-resource-content', {

			path: workspace + '/codemirror/js/',
			parserfile: 'parsexml.js',
			stylesheet: workspace + '/codemirror/css/xmlcolors.css',
			lineNumbers: true,
			tabMode: 'shift',
			height: '500px'
		});

		var messages = $('.message');
		if (messages.length)
		{
			setTimeout((function(el){
				return function(){
					el.addClass('faded');
				}
			})(messages), 5000);
		}
	});
})(jQuery);
