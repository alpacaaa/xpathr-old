<?php

	class SnippetParametersException extends Exception
	{
	}

	require_once('snippet-processors.php');
	require_once('class.snippet-data.php');

	class SnippetParameters extends SnippetData
	{
		protected $data;
		protected $processor;

		public function __construct(Snippet $snippet)
		{
			parent::__construct($snippet);
			$this->processor = new RawDataProcessor();
		}
		
		public function getData()
		{
			if ($this->data) return $this->data;
			if (!$this->storage->hasKey('parameters'))
				return $this->data = array();

			return $this->data = self::load(
				$this->storage->retrieve('parameters')
			);
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
		
		public function save()
		{
			$this->storage->store(
				'parameters', serialize($this->getData)
			);
		}

		public static function find(Snippet $snippet)
		{
			if (!parent::find('parameters', $snippet))
			{
				throw new SnippetParametersException(
					'Snippet has no parameter'
				);
			}

			return new self($snippet);
		}

		public static function load($str)
		{
			return unserialize($str);
		}
	}
