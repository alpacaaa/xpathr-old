<?php

	interface ResourceProcessor {
		public function process(SnippetResource $resource);
	}

	class EmptyResourceProcessor implements ResourceProcessor
	{
		public function process(SnippetResource $resource)
		{
			return '';
		}
	}
	
	class RawResourceProcessor implements ResourceProcessor
	{
		public function process(SnippetResource $resource)
		{
			return $resource->getContent();
		}
	}
	
	class EncodedResourceProcessor implements ResourceProcessor
	{
		public function process(SnippetResource $resource)
		{
			return htmlentities($resource->getContent());
		}
	}
