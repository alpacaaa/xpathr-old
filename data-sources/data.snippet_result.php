<?php

	require_once(TOOLKIT . '/class.datasource.php');

	class datasourcesnippet_result extends Datasource{
		
		public $dsParamROOTELEMENT = 'snippet-result';

		public function about(){
			return array(
					 'name' => 'Snippet Result',
					 'author' => array(
							'name' => 'Marco Sampellegrini',
							'website' => 'http://192.168.1.57/ninja',
							'email' => 'm@rcosa.mp'),
					 'version' => '1.0',
					 'release-date' => '2010-10-21T08:59:20+00:00');	
		}

		public function allowEditorToParse(){
			return false;
		}
		
		public function grab(&$param_pool=NULL){
			$result = new XMLElement($this->dsParamROOTELEMENT);
			$url  = $this->_env['env']['url'];
			$snip = $url['snip-id'];
			$user = $url['user'];

			$snippet = Snippet::find($snip, $user);
			try {
				$process = $snippet->process();
				$result->setValue($process);
			}
			catch (SnippetProcessException $ex)
			{
				$result->appendChild(
					new XMLElement('message', $ex->getMessage())
				);
			}

			return $result;
		}
	}

