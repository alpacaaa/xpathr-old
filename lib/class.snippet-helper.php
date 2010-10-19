<?php

	require_once('class.snippet.php');

	class SnippetHelper
	{
		private class __construct(){ }
		
		public static function getUserDataFolder()
		{
			$dir = Symphony::Configuration()->get('ninja', 'user-data');
			if (!$dir) $dir = WORKSPACE. '/user-data/';

			if (!is_dir($dir) || !is_writeable($dir))
				throw new SnippetException(
					'User data folder does not exist or have wrong permission'
				);

			return $dir;
		}

		public static function findById($snip, $user)
		{
			$snippet = SymRead(self::$section)
				->getAll()
				->where('uniq-id', $snip)
				//->where('user', $user);
				->perPage(1);

			$data = $snippet->readDataIterator()->current();
			if (!$data) return null;

			return new self($snippet, $data);
		}

		public static function findSnippetFromEnv($env)
		{
		
		}

		public static function sanitizeFileName($file)
		{
			return $file;
		}

		public static function cleanParameter($param)
		{
			return trim('$', $param);
		}
	}
