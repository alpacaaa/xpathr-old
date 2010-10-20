<?php

	require_once(TOOLKIT . '/class.datasource.php');
	require_once(WORKSPACE. '/lib/class.snippet.php');
	
	class datasourcesnippet_main_resources extends Datasource{
		
		public $dsParamROOTELEMENT = 'snippet-main-resources';

		public function about(){
			return array(
					 'name' => 'Snippet Main Resources',
					 'author' => array(
							'name' => 'Marco Sampellegrini',
							'website' => 'http://192.168.1.57/ninja',
							'email' => 'm@rcosa.mp'),
					 'version' => '1.0',
					 'release-date' => '2010-10-19T14:16:49+00:00');	
		}

		public function allowEditorToParse(){
			return false;
		}
		
		public function grab(&$param_pool=NULL){
			$result = new XMLElement($this->dsParamROOTELEMENT);
				
			try {
				$snippet = Snippet::findFromEnv($this->_env);
				$main = $snippet->getMainResources();
				foreach ($main as $resource)
					$result->appendChild($resource->toXMLElement());
			}
			catch(SnippetException $e) {
				$result->appendChild(new XMLElement('error', $e->getMessage()));
				return $result;
			}

			return $result;
		}
	}

