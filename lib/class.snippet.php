<?php

	require_once('class.snippet-resource.php');
	require_once('class.snippet-parameters.php');


	class SnippetException extends Exception
	{
	}

	class SnippetProcessException extends Exception
	{
	}

	class Snippet
	{
		public static $section = 'snippets';

		protected $data;

		public function __construct(array $data = array())
		{
			$this->data = $data;
		}
		
		public function listResources()
		{
			return SnippetResource::listAll($this);
		}
		
		public function getResource($file)
		{
			return SnippetResource::find($file, $this);
		}

		public function get($what)
		{
			return $this->data[$what];
		}
		
		public function getUser()
		{
			return 'all';
		}

		public function isMainResource(SnippetResource $resource)
		{
			$type = $resource->getType();
			$main = $this->get('main-'. $type. '-file');

			return $main == $resource->getFile();
		}
		
		public function getMainResources()
		{
			$ret = array(
				'main-xml-file' => null,
				'main-xsl-file' => null
			);

			try {
				$ret['main-xml-file'] = $this->getResource(
					$this->get('main-xml-file')
				);
				$ret['main-xsl-file'] = $this->getResource(
					$this->get('main-xsl-file')
				);
			} catch(SnippetResourceException $ex){ }

			return $ret;
		}
		
		public function process()
		{
			$files = $this->getMainResources();
			$proc  = new XSLTProcessor;

			foreach ($files as $f)
			{
				try {
					$resource = $this->getResource($f);
				}
				catch (SnippetException $ex) {
					throw new SnippetProcessException(
						'Not enough resources to proceed'
					);
				}

				if ($resource->isXML())
					$xml = $resource->toDomDocument();

				if ($resource->isXSL())
				{
					$xsl = $resource->toDomDocument();
					$proc->importStyleSheet($xsl);
				}
			}
			
			//$proc->setParameter('', $parameters);
			return $proc->transformToXML($xml);
		}

		public function saveResource($file, $content)
		{
			if ($file !== SnippetHelper::sanitizeFilename($file))
				throw new SnippetException('Filename is badformed');

			$dir = $this->getSnippetFolder();
			if (!file_put_contents($dir. '/'. $file, $content))
				throw new SnippetException(
					'An error occurred while attempting to save'
				);
		}

		public function saveParameters($data)
		{
			$rows = array_map('trim', explode("\n", $data));
			$params = array();
			foreach ($rows as $i => $row)
			{
				if (strpos($row, '=') === false)
					throw new SnippetException(
						'You have an error on line '. ($i+1)
					);

				list($k, $v) = array_map('trim', explode('=', $row));
				$k = SnippetHelper::cleanParameter($k);

				$first = substr($v, 0, 1);
				$last  = substr($v, -1);

				if (($first == "'" || $first == '"')
				&& $first !== $last && !is_numeric($v))
				{
					throw new SnippetException(
						'You have an error on line '. ($i+1)
					);
				}

				$params[$k] = is_numeric($v) ? (float) $v : (string) $v;
			}

			$this->saveResource('parameters', serialize($params));
		}
		
		public function save($data)
		{
			$fields = array(
				'uniq-id', 'title', 'description',
				'main-xml-file', 'main-xsl-file'
			);

			$query = SymWrite(self::$section);
			foreach ($fields as $f)
			{
				if (isset($data[$f])) $data[$f] = $this->get($f);
				$query->set($f, $data[$f]);
			}
			
			
			return $query->write();
		}

		public function setAsMainResource(SnippetResource $resource)
		{
			$data = array();

			if ($resource->isXML())
				$data['main-xml-file'] = $file;
			else
				$data['main-xsl-file'] = $file;

			return $this->save($data);
		}
		
		public function getParameters()
		{
			try {
				return SnippetParameters::find($this);
			}catch (SnippetParametersException $ex) {
				return new SnippetParameters($this);
			}
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

			$data = array_map(array('self', 'keepValue'), $data);
			return new self($data);
		}
		
		public static function findFromEnv($env)
		{
			$url  = $env['env']['url'];
			$snip = $url['snip-id'];
			$user = $url['user'];
			if (!$user) $user = 'all';

			$obj = self::findById($snip, $user);
			if (!is_object($obj))
			{
				throw new SnippetException(
					'Snippet does not exist'
				);
			}

			return $obj;
		}
		
		public static function keepValue($el)
		{
			if (is_array($el) && array_key_exists('value', $el))
				return $el['value'];
		}
	}
