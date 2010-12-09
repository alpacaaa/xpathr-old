<?php

	class SnippetCache
	{
		protected static $cache;

		public static function init(Cache_Lite $cache)
		{
			self::$cache = $cache;
		}

		public static function purge(Snippet $snippet)
		{
			if (!self::$cache) return;

			$group = $snippet->getUser(). '/'. $snippet->get('uniq-id');
			self::$cache->clean($group);
		}
	}
