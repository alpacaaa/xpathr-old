<?php

	interface SnippetDataProcessor {
		public function processResource(SnippetResource $resource);
		public function processParameters(SnippetParameters $parameters);
	}

	class EmptyDataProcessor implements SnippetDataProcessor
	{
		public function processResource(SnippetResource $resource)
		{
			return '';
		}

		public function processParameters(SnippetParameters $parameters)
		{
			return '';
		}
	}
	
	class RawDataProcessor implements SnippetDataProcessor
	{
		public function processResource(SnippetResource $resource)
		{
			return $resource->getContent();
		}
		
		public function processParameters(SnippetParameters $parameters)
		{
			$params = $parameters->getData();
			return self::buildXML($params);
		}
		
		public static function buildXML(array $params, $function = null)
		{
			$return = '';
			foreach ($params as $k => $v)
			{
				if ($function)
				{
					$k = $function($k);
					$v = $function($v);
				}

				$element = new XMLElement('param', $v, array('key' => $k));
				$return .= $element->generate();
			}

			return $return;
		}
	}
	
	class EncodedDataProcessor extends RawDataProcessor
	{
		public function processResource(SnippetResource $resource)
		{
			return htmlentities("\n". parent::processResource($resource));
		}

		public function processParameters(SnippetParameters $parameters)
		{
			$params = $parameters->getData();
			return self::buildXML($params, 'htmlentities');
		}
	}

	class BitterHighlighterDataProcessor extends EncodedDataProcessor
	{
		protected $bitter;

		public function processResource(SnippetResource $resource)
		{
			$bitter = $this->getBitter();
			$bitter->loadLanguage($resource->getType());

			$result = new XMLElement(
				'div', $bitter->process($resource->getContent())
			);
			$result->setAttribute('class', 'source');

			return $result->generate();
		}

		protected function getBitter()
		{
			if ($this->bitter) return $this->bitter;

			if (!defined('BITTER_LANGUAGE_PATH')) {
				define('BITTER_LANGUAGE_PATH', EXTENSIONS . '/debugdevkit/lib/bitter/languages');
			}

			if (!defined('BITTER_FORMAT_PATH')) {
				define('BITTER_FORMAT_PATH', EXTENSIONS . '/debugdevkit/lib/bitter/formats');
			}

			if (!defined('BITTER_CACHE_PATH')) {
				define('BITTER_CACHE_PATH', CACHE);
			}

			require_once(EXTENSIONS . '/debugdevkit/lib/bitter/bitter.php');
			$bitter = new Bitter();
			$bitter->loadFormat('ninja');

			$this->bitter = $bitter;
			return $bitter;
		}
	}
