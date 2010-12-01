
(function($) {
	$(document).ready(function(){

			bespin.useBespin("snippet-resource-content").then(function(env) {

				var el  = $('.bespin');
				var add = parseInt(el.css('margin-bottom').replace('px', ''));
				var uau = parseInt(el.css('height').replace('px', '')) + add;
				el.css('height', uau + 'px');
				el.css('overflow', 'hidden');

				var hash = window.location.hash;
				if (hash) env.editor.setLineNumber(parseInt(hash.replace('#line-', '')));
				//env.editor.syntax = "xml";
				//env.settings.set('theme', 'white');
			});
		});
})(jQuery);
