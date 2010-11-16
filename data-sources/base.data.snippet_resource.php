<?php

	require_once(TOOLKIT . '/class.datasource.php');

	abstract class baseDataSnippetResource extends Datasource{
		
		public $dsParamROOTELEMENT = 'snippet-resource';

		public function allowEditorToParse(){
			return false;
		}

		public function grab(&$param_pool=NULL){
			$result = new XMLElement($this->dsParamROOTELEMENT);

			$url  = $this->_env['env']['url'];
			$snip = $url['snip-id'];
			$user = $url['user'];
			$file = $url['resource'];

			
			$processor = $this->getProcessor();

			try {
				$snippet  = Snippet::find($snip, $user);
				$resource = $snippet->getResource($file);
				if (!$resource) throw new Exception(
					'The resource does not exist'
				);

				$resource->setProcessor($processor);
				$result->appendChild($resource->toXMLElement());
			}
			catch(Exception $e) {
				$result->appendChild(new XMLElement('error', $e->getMessage()));
				return $result;
			}

			return $result;
		}
		
		abstract public function getProcessor();
	}

