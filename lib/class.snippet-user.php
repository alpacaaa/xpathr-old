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

			self::$data['id'] = self::getUserId(self::$data['name']);
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
			$cookie->set('snippets', array_unique(self::$data['snippets']));
		}

		public static function getCookie()
		{
			return new Cookie('ninja-user', TWO_WEEKS, __SYM_COOKIE_PATH__);
		}

		public static function getName()
		{
			return self::$data['name'];
		}

		public static function getId()
		{
			return self::$data['id'];
		}

		public static function getSnippets()
		{
			if (self::isLoggedIn())
			{
				// symquery
				return;
			}

			return self::$data['snippets'];
		}

		public static function getUserId($name)
		{
			$user = SymRead(Snippet::getUserSection())
				->get(SymRead::SYSTEM_ID)
				->where('name', $name)
				->perPage(1);

			$data = $user->readDataIterator()->current();
			if (!$data) return null;

			return $data['system:id'];
		}

		public static function isLoggedIn()
		{
			return self::$data['openid'];
		}

		public static function addFlashMsg($msg, $type = 'success')
		{
			$cookie = self::getCookie();
			$flash  = $cookie->get('flash');
			if (!is_array($flash)) $flash = array();

			$flash[] = array('msg' => $msg, 'type' => $type);
			$cookie->set('flash', $flash);
		}

		public static function getFlash()
		{
			$cookie = self::getCookie();
			$flash  = $cookie->get('flash');
			if (!is_array($flash)) $flash = array();

			return $flash;
		}

		public static function cleanFlash()
		{
			self::getCookie()->set('flash', array());
		}
	}

	//SnippetUser::init();
