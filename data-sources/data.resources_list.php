<?php

	require_once(TOOLKIT . '/class.datasource.php');

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

			$snippet = Snippet::findFromEnv();
			if (!$snippet) return $result;

			$emptyProcessor = new EmptyDataProcessor();
				
			try {
				$list = $snippet->listResources();

				foreach ($list as $resource)
				{
					$resource->setProcessor($emptyProcessor);
					$result->appendChild($resource->toXMLElement());
				}
			}
			catch(SnippetException $e) {
				$result->appendChild(new XMLElement('error', $e->getMessage()));
				return $result;
			}

			return $result;
		}
	}

