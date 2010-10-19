<?php

	require_once(TOOLKIT . '/class.datasource.php');
	require_once(WORKSPACE. '/class.snippet-helper.php');


	class datasourcesnippet_parameters extends Datasource{
		
		public $dsParamROOTELEMENT = 'snippet-parameters';

		public function about(){
			return array(
					 'name' => 'Snippet Parameters',
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
				
			try {
				$snippet = Snippet::findFromEnv($this->_env);
				$params  = $snippet->getParameters();
				$result->appendChild($resource->toXMLElement());
			}
			catch(Exception $e) {
				$result->appendChild(new XMLElement('error', $e->getMessage()));
				return $result;
			}

			return $result;
		}
	}

