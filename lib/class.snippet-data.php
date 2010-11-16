<?php

	require_once('snippet-storage.php');

	abstract class SnippetData
	{
		protected $snippet;
		protected $storage;
		protected static $storageClass = 'FilesystemStorage';

		public function __construct(Snippet $snippet)
		{
			$klass = self::$storageClass;
			$this->storage = new $klass;
			$this->snippet = $snippet;

			$this->storage->setContext($snippet);
		}

		public static function find($key, Snippet $snippet)
		{
			$storage = self::getStorage($snippet);
			return $storage->hasKey($key);
		}

		public static function getStorage(Snippet $snippet)
		{
			$storage = new self::$storageClass;
			$storage->setContext($snippet);
			return $storage;
		}

		public static function setStorageClass($class)
		{
			self::$storageClass = $class;
		}

		abstract public function save();
	}
