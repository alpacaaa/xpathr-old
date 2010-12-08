
(function($) {
	$(document).ready(function(){

		var workspace = $("head link[rel='workspace']").attr('href');

		if (typeof(CodeMirror) !== 'undefined')
		{
			var editor = CodeMirror.fromTextArea('snippet-resource-content', {

				path: workspace + '/codemirror/js/',
				parserfile: 'parsexml.js',
				stylesheet: workspace + '/codemirror/css/xmlcolors.css',
				lineNumbers: true,
				tabMode: 'shift',
				height: '500px',
				onLoad: function(editor){
					var hash = location.hash;
					if (hash)
					{
						hash = parseInt(hash.replace('#line-', ''));
						editor.jumpToLine(hash);
					}

				}
			});

		}

		var messages = $('.message');
		if (messages.length)
		{
			setTimeout((function(el){
				return function(){
					el.addClass('faded');
				}
			})(messages), 5000);
		}

		$('#resource #resource-delete').click(function(e){
			if (!confirm('Are you sure you want to delete this resource?'))
				return e.preventDefault();
		});

	});
})(jQuery);
