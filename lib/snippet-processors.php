<?php

	interface SnippetDataProcessor {
		public function process(SnippetResource $resource);
	}

	class EmptyDataProcessor implements SnippetDataProcessor
	{
		public function process(SnippetResource $resource)
		{
			return '';
		}
	}
	
	class RawDataProcessor implements SnippetDataProcessor
	{
		public function process(SnippetResource $resource)
		{
			return $resource->getContent();
		}
	}
	
	class EncodedDataProcessor extends RawDataProcessor
	{
		public function process(SnippetResource $resource)
		{
			return htmlentities("\n". parent::process($resource));
		}
	}

	class BitterHighlighterDataProcessor implements SnippetDataProcessor
	{
		protected $bitter;

		public function process(SnippetResource $resource)
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
