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
			return htmlentities(parent::processResource($resource));
		}

		public function processParameters(SnippetParameters $parameters)
		{
			$params = $parameters->getData();
			return self::buildXML($params, 'htmlentities');
		}
	}
