<?php

	require_once(TOOLKIT . '/class.datasource.php');

	class datasourcesnippet_resource extends Datasource{
		
		public $dsParamROOTELEMENT = 'snippet-resource';

		public function about(){
			return array(
					 'name' => 'Snippet Resource (Bitter Highlighter)',
					 'author' => array(
							'name' => 'Marco Sampellegrini',
							'website' => 'http://192.168.1.57/ninja',
							'email' => 'm@rcosa.mp'),
					 'version' => '1.0',
					 'release-date' => '2010-10-19T07:59:07+00:00');	
		}

		public function allowEditorToParse(){
			return false;
		}

		public function grab(&$param_pool=NULL){
			$result = new XMLElement($this->dsParamROOTELEMENT);

			$url  = $this->_env['env']['url'];
			$snip = $url['snip-id'];
			$user = $url['user'];
			$file = $url['resource'];

			try {
				$snippet  = Snippet::find($snip, $user);
				$resource = $snippet->getResource($file);
				if (!$resource) throw new Exception(
					'The resource does not exist'
				);

				if (SnippetUser::owns($snippet))
					$processor = new EncodedDataProcessor();
				else
					$processor = new BitterHighlighterDataProcessor();

				$resource->setProcessor($processor);
				$result->appendChild($resource->toXMLElement());
			}
			catch(Exception $e) {
				$result->appendChild(new XMLElement('error', $e->getMessage()));
				return $result;
			}

			return $result;
		}
	}

