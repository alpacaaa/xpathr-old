<?php

	require_once('class.snippet-resource.php');
	require_once('class.snippet-cache.php');
	require_once('class.snippet-user.php');

	class SnippetException extends Exception
	{
	}


	class Snippet
	{
		public static $section = 'snippets';

		protected $data;

		public function __construct(array $data = array())
		{
			$this->data = $data;
			//SnippetUser::add($this);
		}
		
		public function listResources()
		{
			return SnippetResource::listAll($this);
		}
		
		public function getResource($file)
		{
			return SnippetResource::find($file, $this);
		}

		public function get($what = null)
		{
			if ($what) return $this->data[$what];
			return $this->data;
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
			$proc  = new XsltProcess;

			foreach ($resources as $resource)
			{
				if ($resource->isXML())
					$xml = $resource->getContent();
					//$xml = $resource->toDomDocument();

				if ($resource->isXSL())
				{
					//$xsl = $resource->toDomDocument();
					//$proc->importStyleSheet($xsl);
					$xsl = '<?xml version="1.0" encoding="UTF-8"?>
					<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
						<xsl:import href="'. $resource->getPath(). '"/>
					</xsl:stylesheet>';
				}
			}

			/*
			$parameters = $this->getParameters()->getData();
			$proc->setParameter('', $parameters);
			*/

			$processed = $proc->process($xml, $xsl);
			if (!$proc->isErrors()) return $processed;

			$path = SnippetData::getStorage($this)->getUserDataFolder();
			$resources = $this->getMainResources();
			$main_xml  = $resources['main-xml-file']->getFile();

			$ex = new SnippetProcessException;
			$ex->buildErrorsNode($proc, $path, $main_xml);
			throw $ex;
		}

		public function getParameters()
		{
			try {
				return SnippetParameters::find($this);
			}catch (SnippetParametersException $ex) {
				return new SnippetParameters($this);
			}
		}

		public static function find($snip, $user = null)
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

		protected static function create(array $data, array $resources)
		{
			$data['last-update'] = '';

			$code = $data['uniq-id'];
			if (!$code)
			{
				$user = SnippetUser::getName();

				do
				{
					$code = self::generateUniqId();
				}
				while (is_object(self::find($code, $user)));
				$data['uniq-id'] = $code;
			}

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
			if (!$init) return false;

			foreach ($resources as $r)
			{
				if ($r instanceof SnippetResource)
				{
					$file = $r->getFile();
					$text = $r->getContent();
				}
				else
				{
					$file = $r['file'];
					$text = $r['text'];
				}

				$resource = new SnippetResource($file, $snippet);
				$resource->setContent($text);
				$ret = $resource->save();
				if (!$ret) return false;
			}

			SnippetUser::add($snippet);
			return $code;
		}

		public static function createNew()
		{
			$resources = array(
				'xml' => array(
					'file' => 'source.xml',
					'text' => join("\n", array(
						'<source>',
						'	<paste>Paste here :)</paste>',
						'</source>'
						))
				),
				'xsl' => array(
					'file' => 'master.xsl',
					'text' => join("\n", array(
						'<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">',
						'',
						'	<xsl:output method="xml" indent="yes" />',
						'',
						'	<xsl:template match="/">',
						'',
						'		<result>',
						'			<xsl:value-of select="source/paste" />',
						'		</result>',
						'',
						'	</xsl:template>',
						'</xsl:stylesheet>'
						))
				)
			);

			$data  = array(
				'title' => 'Yet another snippet',
				'main-xml-file' => $resources['xml']['file'],
				'main-xsl-file' => $resources['xsl']['file']
			);

			return self::create($data, $resources);
		}

		public function fork()
		{
			$anonymous = $this->getUser() == self::anonymousUser();
			if (!$anonymous)
			{
				$user = SnippetUser::getName();
				if ($user == $this->getUser())
					throw new SnippetException(
						'You already have a fork of this snippet'
					);
			}

			$resources = $this->listResources();
			$data = $this->get();
			$data['description'] .= ' (fork)';
			$data['forked-from']  = $this->getUser(). '/'. $this->get('uniq-id');
			if ($anonymous) unset($data['uniq-id']);

			return self::create($data, $resources);
		}

		public static function generateUniqId()
		{
			return substr(md5(time(). rand()), rand(0, 22), 10);
		}
	}




	class SnippetProcessException extends Exception
	{
		public $node;

		public function __construct($msg = null)
		{
			$this->node = new XMLElement('message', $msg);
		}

		public function buildErrorsNode($proc, $path, $main_xml)
		{
			$errors_grouped = array();

			while (list($key, $val) = $proc->getError())
			{

				if (preg_match('/^loadXML\(\)/i', $val['message'])
				&& preg_match_all('/line:\s+(\d+)/i', $val['message'], $matches))
				{
					$errors_grouped['xml'][] = array('line'=>$matches[1][0], 'raw'=>$val);
				}
				else
				{
					preg_match_all('/([^.\/]+\.xsl)\s+line\s+(\d+)/i', $val['message'], $matches);
					$errors_grouped['general'][$matches[1][0]][] = array(
						'line'=>$matches[2][0], 'message'=> $val['message']
					);
				}
			};


			$result = new XMLElement('processing-errors');

			foreach ($errors_grouped as $group => $data)
			{
				if ($group == 'general')
				{
					if (!isset($general)) $general = new XMLElement('general');

					foreach ($data as $filename => $errors)
					{
						foreach ($errors as $e)
						{
							$message = str_replace($path, '', $e['message']);
							$line = $e['line'];

							$obj = $general;
							if ($line)
							{
								if (!isset($stack)) $stack = new XMLElement('stack');

								$stack->setAttribute('line', $line);
								$stack->setAttribute('filename', $filename);
								$obj = $stack;
							}

							$obj->appendChild(new XMLElement(
								'message', htmlentities($message)
							));
						}
					}
				}

				if ($group == 'xml')
				{
					if (!isset($general)) $xml = new XMLElement('xml');
					$xml->setAttribute('filename', $main_xml);

					foreach ($data as $e)
					{
						$xml->setAttribute('line', $e['line']);
						$xml->appendChild(new XMLElement(
							'message', htmlentities($e['raw']['message'])
						));
					}
				}
			}

			if (isset($general)) $result->appendChild($general);
			if (isset($stack)) $result->appendChild($stack);
			if (isset($xml)) $result->appendChild($xml);

			$this->node = $result;
		}

		public function getErrorsAsNode()
		{
			return $this->node;
		}
	}
