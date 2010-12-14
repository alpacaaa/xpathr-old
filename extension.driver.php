<?php

	require_once(EXTENSIONS. '/ninja/lib/class.snippet.php');

	class extension_Ninja extends Extension
	{
		protected static $owner;
		protected static $snippet;

		public function __construct()
		{
			if (!class_exists('Frontend')) return;
			SnippetUser::init();

			$em = new ExtensionManager(Frontend::instance());
			$ex = $em->create('cachelite', array(), true); //silent
			if (!is_object($ex)) return;

			$obj = $ex->getCacheLite();
			SnippetCache::init($obj);
		}

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
				array(
					'page' => '/frontend/',
					'delegate' => 'cacheLitePreExecute',
					'callback' => 'cacheLitePreExecute'
				),
			);
		}

		public function FrontendParamsResolve(&$context)
		{
			$owner = self::userIsOwner();
			if (!empty($_POST) || $context['params']['url-edit'])
			{
				if (!$owner)
					return $context['params']['url-edit'] = 'nada';
			}

			$context['params']['owner'] = $owner ? 'true' : 'false';
		}

		public function cacheLitePreExecute(&$context)
		{
			if (
				$_SERVER['REQUEST_METHOD'] == 'POST' ||
				count(SnippetUser::getFlash()) > 0
			)
			{
				$context['continue'] = false;
				return;
			}

			$snippet = self::getSnippet();
			if (!$snippet) return;

			$owner = self::userIsOwner();
			$context['url'] .= 'owner='. ($owner ? 'true' : 'false');
			$context['group'] = $snippet->getUser(). '/'. $snippet->get('uniq-id');
		}

		public static function userIsOwner()
		{
			if (isset(self::$owner)) return self::$owner;

			$snippet = self::getSnippet();
			if (!$snippet) return self::$owner = false;

			$owner = SnippetUser::owns($snippet);
			return self::$owner = $owner;
		}

		public static function getSnippet()
		{
			if (isset(self::$snippet)) return self::$snippet;
			$env  = self::getEnv();

			$user = $env['url']['user'];
			$snip = $env['url']['snip-id'];
			return self::$snippet = Snippet::find($snip, $user);
		}

		public static function getResource()
		{
			$env  = self::getEnv();

			$file = $env['url']['resource'];
			return self::getSnippet()->getResource($file);
		}

		public static function getEnv()
		{
			return Frontend::instance()->Page()->Env();
		}
	}
