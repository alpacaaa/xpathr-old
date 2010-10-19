<?php

	require_once('resource-processors.php');

	class SnippetResource
	{
		protected $path;
		protected $main;
		protected $file;
		protected $content;
		protected $processor;

		public function __construct($file, $main = false)
		{
			$this->path = $file;
			$this->main = $main;
			$this->file = basename($file);
			$this->processor = new RawResourceProcessor();
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
			return 'xml' == self::getType($this->file);
		}
		
		public function isXSL()
		{
			return 'xsl' == self::getType($this->file);
		}

		public function getContent()
		{
			if ($this->content) return $this->content;
			return $this->content = file_get_contents($this->path);
		}
		
		public function getProcessedContent()
		{
			return $this->processor->process($this);
		}
		
		public function setProcessor(ResourceProcessor $processor)
		{
			$this->processor = $processor;
		}

		public static function getType($file)
		{
			return substr($file, -3);
		}
	}
