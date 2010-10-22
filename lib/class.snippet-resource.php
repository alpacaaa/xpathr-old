<?php

	class SnippetResourceException extends Exception
	{
	}

	require_once('snippet-processors.php');
	require_once('class.snippet-data.php');

	class SnippetResource extends SnippetData
	{
		protected $path;
		protected $main;
		protected $file;
		protected $content;
		protected $processor;

		public function __construct($file, Snippet $snippet)
		{
			parent::__construct($snippet);

			$this->file = $file;
			$this->main = $snippet->isMainResource($this);
			$this->processor = new RawDataProcessor();
		}

		public function toXMLElement()
		{
			$xml = new XMLElement('resource');
			$xml->setValue($this->getProcessedContent());
			$xml->setAttribute('file', $this->file);
			$xml->setAttribute('main', $this->main ? 'true' : 'false');
			$xml->setAttribute('type', self::getType($this));

			return $xml;
		}

		public function save()
		{
			$content = $this->getContent();
			$this->file = self::clean($this->file);
			return $this->storage->store($this->file, $content);
		}
		
		public function toDomDocument()
		{
			$dom = new DomDocument();
			$dom->load($this->storage->buildPath($this->file));

			return $dom;
		}
		
		public function isXML()
		{
			return 'xml' == $this->getType();
		}
		
		public function isXSL()
		{
			return 'xsl' == $this->getType();
		}

		public function getContent()
		{
			if ($this->content) return $this->content;
			return $this->content = $this->storage->retrieve($this->file);
		}

		public function setContent($content)
		{
			$this->content = $content;
		}
		
		public function getProcessedContent()
		{
			return $this->processor->processResource($this);
		}
		
		public function setProcessor(SnippetDataProcessor $processor)
		{
			$this->processor = $processor;
		}

		public function getType()
		{
			return substr($this->file, -3);
		}
		
		public function getFile()
		{
			return $this->file;
		}

		public function delete()
		{
			return $this->storage->delete($this->getFile());
		}

		public function rename($newfile)
		{
			$newfile = self::clean($newfile);
			if (empty($newfile))
				throw new SnippetResourceException(
					'Bad filename'
				);

			if ($this->storage->hasKey($newfile))
				throw new SnippetResourceException(
					'File already exists'
				);


			if (!$this->delete())
				throw new SnippetResourceException(
					'Cannot delete resource'
				);

			return $this->file = $newfile;
		}

		public static function find($file, Snippet $snippet)
		{
			if (!parent::find($file, $snippet)) return null;
			return new self($file, $snippet);
		}

		public static function listAll(Snippet $snippet)
		{
			$list = self::getStorage($snippet)->getAllKeys();
			$ret  = array();
			foreach ($list as $file)
				if ($file !== 'parameters')
					$ret[] = new self($file, $snippet);

			return $ret;
		}

		public static function clean($str)
		{
			$str = strtolower($str);
			return preg_replace("/([^a-z0-9\.\-]+)/", "", $str);
		}
	}
