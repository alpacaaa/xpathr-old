<?php

	class SnippetUser
	{
		public static $data = array();

		public static function init()
		{
			$cookie = self::getCookie();

			self::$data['snippets'] = $cookie->get('snippets') ?
				$cookie->get('snippets') : array();

			self::$data['name'] = $cookie->get('name') ?
				$cookie->get('name') : Snippet::anonymousUser();

			self::$data['openid'] = $cookie->get('openid');
		}

		public static function owns(Snippet $snippet)
		{
			$user = $snippet->getUser();
			if (self::$data['openid'])
				return self::$data['name'] == $user;

			if ($user !== Snippet::anonymousUser()) return false;

			return in_array($snippet->get('uniq-id'), self::$data['snippets']);
		}

		public static function add(Snippet $snippet)
		{
			if (self::isLoggedIn()) return;

			self::$data['snippets'][] = $snippet->get('uniq-id');

			$cookie = self::getCookie();
			$cookie->set('snippets', self::$data['snippets']);
		}

		public static function getCookie()
		{
			return new Cookie('ninja-user', TWO_WEEKS, __SYM_COOKIE_PATH__);
		}

		public static function getName()
		{
			return self::$data['name'];
		}

		public static function isLoggedIn()
		{
			return self::$data['openid'];
		}
	}

	SnippetUser::init();
