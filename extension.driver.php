<?php

	require_once(EXTENSIONS. '/ninja/lib/class.snippet.php');

	class extension_Ninja extends Extension
	{
		public function about()
		{
			return array(
				'name' => 'XPath Ninja',
				'version' => '1.0',
				'release-date' => '2010-11-16',
				'author' => array(
					'name' => 'Marco Sampellegrini',
					'email' => 'm@rcosa.mp'
				)
			);
		}

		public function getSubscribedDelegates()
		{
			return array(
				array(
					'page' => '/frontend/',
					'delegate' => 'FrontendParamsResolve',
					'callback' => 'FrontendParamsResolve'
				),
			);
		}

		public function FrontendParamsResolve(&$context)
		{
			if ($context['params']['current-page'] == 'edit' ||
				$context['params']['parent-path'] == '/edit')
			{
				$user = SnippetUser::getName();
				$snip = $context['params']['snip-id'];
				$snippet = Snippet::find($snip, $user);

				if (!$snippet || !SnippetUser::owns($snippet)) return;
			}

			$context['params']['owner'] = true;
		}
	}
