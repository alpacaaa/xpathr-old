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
			$dir  = self::getUserDataFolder();
			$dir .= $this->getUser(). '/'. $this->get('uniq-id');

			if (!is_dir($dir)) return array();

			$list = glob($dir. '/*');
			$ret  = array();
			foreach ($list as $file)
			{
				$ret[] = new SnippetResource(
					$file,
					$this->isMainResource($file)
				);
			}

			return $ret;
		}
		
		public function getResource($file)
		{
			$dir = $this->getSnippetFolder();
			$file = $dir. '/'. $file;

			if (!file_exists($file))
				throw new SnippetException('The resource does not exist');

			return new SnippetResource(
				$file,
				$this->isMainResource($file)
			);
		}

		public function get($what)
		{
			$ret = $this->data[$what];
			if (!is_array($ret)) return $ret;
			return $ret['value'];
		}
		
		public function getUser()
		{
			return 'all';
		}

		public function isMainResource($file)
		{
			$type = SnippetResource::getType($file);
			$main = $this->get('main-'. $type. '-file');

			return $main == basename($file);
		}
		
		public function getMainResources()
		{
			return array(
				$this->get('main-xml-file'),
				$this->get('main-xsl-file')
			);
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
				$params = $this->getResource('parameters');
			}
			catch(SnippetException $ex) {
				return array();
			}

			return unserialize($params->getContent());
		}

		public function getSnippetFolder()
		{
			$dir  = SnippetHelper::getUserDataFolder();
			$dir .= $this->getUser(). '/'. $this->get('uniq-id');

			if (!is_dir($dir))
				throw new SnippetException('Snippet has no resources');

			return $dir;
		}
	}
