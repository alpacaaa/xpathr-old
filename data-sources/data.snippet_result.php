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
			$result->setAttribute('result', 'success');

			try {
				$snippet = Snippet::findFromEnv();

				// fake resource
				$resource  = new SnippetResource('result.xml', $snippet);
				$resource->setContent($snippet->process());
				$resource->setProcessor(new BitterHighlighterDataProcessor);

				$result->setValue($resource->getProcessedContent());
			}
			catch (SnippetProcessException $ex)
			{
				$result->setAttribute('result', 'error');
				$result->appendChild($ex->getErrorsAsNode());
			}

			return $result;
		}
	}

