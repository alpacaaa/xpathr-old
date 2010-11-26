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
			SnippetUser::init();
			$user = SnippetUser::getName();
			$snip = $context['params']['snip-id'];
			$snippet = Snippet::find($snip, $user);

			if (!$snippet) return;
			$owner = SnippetUser::owns($snippet);

			if (!empty($_POST) || $context['params']['url-edit'])
			{
				if (!$owner)
					return $context['params']['url-edit'] = 'nada';
			}

			$context['params']['owner'] = $owner ? 'true' : 'false';
		}
	}
