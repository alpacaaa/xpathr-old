<?php

	require_once(TOOLKIT . '/class.datasource.php');
	require_once(WORKSPACE. '/lib/class.snippet-ds.php');
	
	class datasourcesnippet_data extends baseSnippetDS
	{	
		public $dsParamROOTELEMENT = 'snippet-data';
		
		public function about()
		{
			return array(
					 'name' => 'Snippet Data',
					 'author' => array(
							'name' => 'Marco Sampellegrini',
							'website' => 'http://192.168.1.57/ninja',
							'email' => 'm@rcosa.mp'),
					 'version' => '1.0',
					 'release-date' => '2010-10-14T15:49:57+00:00');	
		}
		
		public function grab(&$param_pool=NULL)
		{
			$result = new XMLElement($this->dsParamROOTELEMENT);

			try {
				$this->execute($result);
			}
			catch (SnippetException $ex) {
				self::appendError($result, $ex->getMessage());
			}

			return $result;
		}
	}
