<?php

	require_once('snippet-processors.php');
	
	class SnippetResourceException extends Exception {}

	class SnippetResource
	{
		protected $path;
		protected $main;
		protected $file;
		protected $snippet;
		protected $content;
		protected $processor;

		public function __construct($file, Snippet $snippet)
		{
			$this->path = $file;
			$this->file = basename($file);
			$this->main = $snippet->isMainResource($this);
			$this->snippet = $snippet;
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
		
		public function toDomDocument()
		{
			$dom = new DomDocument();
			$dom->load($this->path);

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
			return $this->content = file_get_contents($this->path);
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
		
		public static function find($file, Snippet $snippet)
		{
			//TODO check realpath!
			$dir  = $snippet->getSnippetFolder();
			$file = $dir. '/'. $file;
			if (!file_exists($file))
			{
				throw new SnippetResourceException(
					'Resource does not exists'
				);
			}

			return new self($file, $snippet);
		}

		public static function listAll(Snippet $snippet)
		{
			try {
				$dir  = $snippet->getSnippetFolder();
			}catch(SnippetException $ex) {
				return array();
			}

			$list = glob($dir. '/*.*');
			$ret  = array();
			foreach ($list as $file)
				$ret[] = new self($file, $snippet);

			return $ret;
		}
	}
