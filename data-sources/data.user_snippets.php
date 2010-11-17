<?php

	require_once(TOOLKIT . '/class.datasource.php');

	class datasourceuser_snippets extends Datasource{
		
		public $dsParamROOTELEMENT = 'user-snippets';

		public function about(){
			return array(
					 'name' => 'User Snippets list',
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
			$key = 'ds-' . $this->dsParamROOTELEMENT;

			$list = SnippetUser::getSnippets();
			foreach ($list as $snippet)
				$result->appendChild(
					new XMLElement(
						'snippet', null, array('uniq-id' => $snippet)
					)
				);

			$param_pool[$key] = join(',', $list);
			return $result;
		}
	}

