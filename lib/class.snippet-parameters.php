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

		public function setData(array $data)
		{
			$this->data = $data;
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
		
		public function setDataFromString($data)
		{
			$rows = array_filter(array_map('trim', explode("\n", $data)));
			$params = array();
			foreach ($rows as $i => $row)
			{
				$bits = array('=', ' ', "\t");
				$c = 0;
				$len = strlen($row);
				while (++$c < $len) {
					$char = $row[$c];
					if (in_array($char, $bits)) $len = 0;
				}

				if ($c == $len)
				{
					throw new SnippetParametersException(
						'You have an error on line '. ($i+1)
					);
				}
				$k = substr($row, 0, $c);
				$v = substr($row, $c);
				$k = self::clean($k);

				$first = substr($v, 0, 1);
				$last  = substr($v, -1);

				if (($first == "'" || $first == '"')
				&& $first !== $last && !is_numeric($v))
				{
					throw new SnippetParametersException(
						'You have an error on line '. ($i+1)
					);
				}

				if (is_numeric($v)) $params[$k] = (float) $v;
				elseif (is_bool($v)) $params[$k] = (bool) $v;
				else $params[$k] = (string) self::clean($v);
			}

			$this->setData($params);
		}
		
		public function save()
		{
			$this->storage->store(
				'parameters', serialize($this->getData())
			);
		}

		public static function find(Snippet $snippet)
		{
			return new self($snippet);
		}

		public static function load($str)
		{
			return unserialize($str);
		}
		
		public static function clean($str)
		{
			return trim($str, "\t =\"'$");
		}
	}
