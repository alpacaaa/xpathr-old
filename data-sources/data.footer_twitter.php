<?php

	require_once(TOOLKIT . '/class.datasource.php');
	
	Class datasourcefooter_twitter extends Datasource{
		
		public $dsParamROOTELEMENT = 'footer-twitter';
		public $dsParamURL = 'http://search.twitter.com/search.atom?q=%23spongebob';
		public $dsParamXPATH = '/';
		public $dsParamCACHE = '9999';
		public $dsParamTIMEOUT = '6';
		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array();
		}
		
		public function about(){
			return array(
					 'name' => 'Footer Twitter',
					 'author' => array(
							'name' => 'Marco Sampellegrini',
							'website' => 'http://dev/ninja',
							'email' => 'm@rcosa.mp'),
					 'version' => '1.0',
					 'release-date' => '2010-12-05T11:22:54+00:00');	
		}
		
		public function getSource(){
			return 'dynamic_xml';
		}
		
		public function allowEditorToParse(){
			return true;
		}
		
		public function grab(&$param_pool=NULL){
			$result = new XMLElement($this->dsParamROOTELEMENT);
				
			try{
				include(TOOLKIT . '/data-sources/datasource.dynamic_xml.php');
			}
			catch(FrontendPageNotFoundException $e){
				// Work around. This ensures the 404 page is displayed and
				// is not picked up by the default catch() statement below
				FrontendPageNotFoundExceptionHandler::render($e);
			}			
			catch(Exception $e){
				$result->appendChild(new XMLElement('error', $e->getMessage()));
				return $result;
			}	

			if($this->_force_empty_result) $result = $this->emptyXMLSet();
			return $result;
		}
	}

