<?php

	class SnippetException extends Exception
	{
	}

	class SnippetProcessException extends Exception
	{
	}

	class Snippet
	{
		public static $section = 'snippets';

		protected $snippet;
		protected $data;

		public function __construct(SymRead $snippet, array $data)
		{
			$this->snippet = $snippet;
			$this->data = $data;
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
		
		public function listResources()
		{
			$dir  = self::getUserDataFolder();
			$dir .= $this->getUser(). '/'. $this->get('uniq-id');

			if (!is_dir($dir)) return array();
			return array_map('basename', glob($dir. '/*'));
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

		public function getInfo()
		{
			return $this->snippet->readXMLElement($root_element = 'info');
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
			if ($file !== self::clean($file))
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
				$k = self::clean($k);

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
		
		public function saveInfo($data)
		{
			return $this->save(array(
				'title' => $data['title'],
				'description' => $data['description']
			));
		}
		
		public function setAsMainResource($file)
		{
			$resource = $this->getResource($file);
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
				return '';
			}

			return unserialize($params->getContent());
		}

		public function getSnippetFolder()
		{
			$dir  = self::getUserDataFolder();
			$dir .= $this->getUser(). '/'. $this->get('uniq-id');

			if (!is_dir($dir))
				throw new SnippetException('Snippet has no resources');

			return $dir;
		}

		public static function getUserDataFolder()
		{
			$dir = Symphony::Configuration()->get('ninja', 'user-data');
			if (!$dir) $dir = WORKSPACE. '/user-data/';

			if (!is_dir($dir) || !is_writeable($dir))
				throw new SnippetException(
					'User data folder does not exist or have wrong permission'
				);

			return $dir;
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

			return new self($snippet, $data);
		}
		
		public static function clean($str)
		{
			return str_replace('..', '', $str);
		}
	}



	class SnippetResource
	{
		protected $path;
		protected $main;
		protected $file;
		protected $content;

		public function __construct($file, $main = false)
		{
			$this->path = $file;
			$this->main = $main;
			$this->file = basename($file);
		}

		public function toXMLElement($empty = false)
		{
			$xml = new XMLElement('resource');
			$xml->setValue(htmlentities($empty ? '' : $this->getContent()));
			$xml->setAttribute('file', $this->file);
			$xml->setAttribute('main', $this->main ? 'true' : 'false');

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

		public static function getType($file)
		{
			return substr($file, -3);
		}
	}
