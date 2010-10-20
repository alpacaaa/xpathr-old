<?php

	require_once('snippet-processors.php');

	class SnippetParametersException extends Exception {}

	class SnippetParameters extends SnippetResource
	{
		protected $data;
		protected $snippet;
		protected $processor;

		public function __construct(array $data, Snippet $snippet)
		{
			$this->data = $data;
			$this->snippet = $snippet;
			$this->processor = new RawDataProcessor();
		}
		
		public function getData()
		{
			return $this->data;
		}
		
		public function toXMLElement()
		{
			$xml = new XMLElement('parameters');
			$xml->setValue($this->getProcessedContent());

			return $xml;
		}
		
		public function getProcessedContent()
		{
			return $this->processor->processParameters($this);
		}
		
		public static function find(Snippet $snippet)
		{
			$dir  = $snippet->getSnippetFolder();
			$file = $dir. '/parameters';
			if (!file_exists($file))
			{
				throw new SnippetResourceException(
					'Parameters not found'
				);
			}

			$data = self::load(file_get_contents($file));
			return new self($data, $snippet);
		}
		
		public static function load($str)
		{
			return unserialize($str);
		}
	}
