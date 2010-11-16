<?php

	require_once('class.snippet-resource.php');
	require_once('class.snippet-parameters.php');
	require_once('class.snippet-user.php');

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
			$ret = array();

			$xml = $this->get('main-xml-file');
			$xml = empty($xml) ? '' : $this->getResource($xml);

			$xsl = $this->get('main-xsl-file');
			$xsl = empty($xsl) ? '' : $this->getResource($xsl);

			is_object($xml) ? $ret['main-xml-file'] = $xml : null;
			is_object($xsl) ? $ret['main-xsl-file'] = $xsl : null;

			return $ret;
		}
		
		public function process()
		{
			$resources = $this->getMainResources();
			if (count($resources) !== 2)
			{
				throw new SnippetProcessException(
					'Not enough resources to proceed'
				);
			}
			$proc  = new XSLTProcessor;

			foreach ($resources as $resource)
			{
				if ($resource->isXML())
					$xml = $resource->toDomDocument();

				if ($resource->isXSL())
				{
					$xsl = $resource->toDomDocument();
					$proc->importStyleSheet($xsl);
				}
			}

			/*
			$parameters = $this->getParameters()->getData();
			$proc->setParameter('', $parameters);
			*/

			return $proc->transformToXML($xml);
		}

		public function getParameters()
		{
			try {
				return SnippetParameters::find($this);
			}catch (SnippetParametersException $ex) {
				return new SnippetParameters($this);
			}
		}

		public static function find($snip, $user)
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

		public static function findFromEnv($env)
		{
			$url  = $env['env']['url'];
			$snip = $url['snip-id'];
			$user = $url['user'];
			if (!$user) $user = 'all';

			$obj = self::find($snip, $user);
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

		public static function anonymousUser()
		{
			return 'all';
		}

		public static function createNew()
		{
			$user = SnippetUser::getName();

			do
			{
				$code = self::generateUniqId();
			}
			while (is_object(self::find($code, $user)));

			$resources = array(
				'xml' => array(
					'file' => 'source.xml',
					'text' => '<source>Paste here :)</source>'
				),
				'xsl' => array(
					'file' => 'master.xsl',
					'text' => join("\n", array(
						'<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">',
						'	<xsl:output method="text"/>',
						'	<xsl:template match="/">',
						'		<xsl:apply-templates />',
						'	</xsl:template>',
						'</xsl:stylesheet>'
						))
				)
			);

			$data  = array(
				'uniq-id' => $code,
				'title' => 'Snippet #'. $code,
				'main-xml-file' => $resources['xml']['file'],
				'main-xsl-file' => $resources['xsl']['file']
			);

			if (SnippetUser::isLoggedIn())
				$data['user'] = SnippetUser::getId();

			$entry = SymWrite(self::$section);
			foreach ($data as $field => $value)
				$entry->set($field, $value);

			try {
				$entry = $entry->write();
			}
			catch (SymWriteException $ex) {
				return false;
			}

			$snippet = new Snippet($data);
			$storage = SnippetData::getStorage($snippet);

			$init = $storage->initContext();
			if (!$init)
			{
				$em = new EntryManager(Frontend::instance());
				$em->delete($entry);
				return false;
			}

			foreach ($resources as $r)
			{
				$resource = new SnippetResource($r['file'], $snippet);
				$resource->setContent($r['text']);
				$ret = $resource->save();
				if (!$ret) return false;
			}

			SnippetUser::add($snippet);
			return $code;
		}

		public static function generateUniqId()
		{
			return substr(md5(time(). rand()), rand(0, 22), 10);
		}
	}
