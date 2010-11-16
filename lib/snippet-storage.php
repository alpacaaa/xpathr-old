<?php

	class SnippetDataStorageException extends Exception
	{
	}

	interface SnippetDataStorage {
		public function store($key, $value);
		public function retrieve($key);
		public function delete($key);
		public function hasKey($key);
		public function getAllKeys();
		public function setContext(Snippet $context);
		public function initContext();
	}


	class FilesystemStorage implements SnippetDataStorage
	{
		protected $context;
		
		public function store($key, $value)
		{
			$path = $this->buildPath($key);
			return file_put_contents($path, $value);
		}
		
		public function retrieve($key)
		{
			if (!$this->hasKey($key)) return null;

			$file = $this->buildPath($key);
			return file_get_contents($file);
		}

		public function delete($key)
		{
			if (!$this->hasKey($key)) return true;

			$path = $this->buildPath($key);
			return unlink($path);
		}

		public function hasKey($key)
		{
			$file = $this->buildPath($key);
			return $this->checkFile($file);
		}
		
		public function getAllKeys()
		{
			$dir = $this->getSnippetFolder();
			if (!is_dir($dir)) return array();

			return array_map('basename', glob($dir. '/*'));
		}
		
		public function setContext(Snippet $context)
		{
			$this->context = $context;
		}

		public function initContext()
		{
			$dir = $this->getSnippetFolder();
			if (is_dir($dir)) return true;

			return mkdir($dir);
		}

		public function buildPath($key)
		{
			$dir  = $this->getSnippetFolder();
			if (!is_dir($dir))
				throw new SnippetDataStorageException(
					'Error while retrieving data'
				);

			$key  = '/'. trim($key, '/');
			$file = $dir. $key;
			$file = new SplFileInfo($file);
			$path = $file->getPathInfo()->getRealPath();

			if ($path == $dir)
				return $file;

			throw new SnippetDataStorageException(
				'Error while retrieving data'
			);
		}

		public static function checkFile($file)
		{
			return file_exists($file) && !is_dir($file) && is_writeable($file);
		}

		public function getSnippetFolder()
		{
			$dir  = self::getUserDataFolder();
			$dir .= $this->context->getUser(). '/'. $this->context->get('uniq-id');

			return $dir;
		}

		public static function getUserDataFolder()
		{
			$dir = Symphony::Configuration()->get('ninja', 'user-data');
			if (!$dir) $dir = WORKSPACE. '/user-data/';

			if (!is_dir($dir) || !is_writeable($dir))
				throw new SnippetDataStorageException(
					'User data folder does not exist or have wrong permission'
				);

			return $dir;
		}
	}
