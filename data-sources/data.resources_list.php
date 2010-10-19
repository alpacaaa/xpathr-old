<?php

	require_once(TOOLKIT . '/class.datasource.php');
	require_once(WORKSPACE. '/class.snippet-helper.php');


	class datasourceresources_list extends Datasource{
		
		public $dsParamROOTELEMENT = 'resources-list';

		public function about(){
			return array(
					 'name' => 'Resources list',
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
			$all = new XMLElement('all');
			$result->appendChild($all);
			$emptyProcessor = new EmptyResourceProcessor();
				
			try {
				$snippet = Snippet::findFromEnv($this->_env);
				$list = $snippet->listResources();
				foreach ($list as $resource)
				{
					$resource->setProcessor($emptyProcessor);
					$all->appendChild($resource->toXMLElement());
				}
			}
			catch(Exception $e) {
				$result->appendChild(new XMLElement('error', $e->getMessage()));
				return $result;
			}

			return $result;
		}
	}

