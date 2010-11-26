<?php

	require_once(TOOLKIT . '/class.datasource.php');

	class datasourceuser_flash extends Datasource{
		
		public $dsParamROOTELEMENT = 'user-flash';

		public function about(){
			return array(
					 'name' => 'User Flash messages',
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

			$list = SnippetUser::getFlash();
			foreach ($list as $msg)
				$result->appendChild(
					new XMLElement('message', $msg['msg'])
				);

			if ($list)
			{
				SnippetUser::cleanFlash();
				$result->setAttribute('result', 'success');
			}

			return $result;
		}
	}
