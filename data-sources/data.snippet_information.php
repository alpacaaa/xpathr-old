<?php

	require_once(TOOLKIT . '/class.datasource.php');
	
	Class datasourcesnippet_information extends Datasource{
		
		public $dsParamROOTELEMENT = 'snippet-information';
		public $dsParamORDER = 'desc';
		public $dsParamLIMIT = '1';
		public $dsParamREDIRECTONEMPTY = 'yes';
		public $dsParamREQUIREDPARAM = '$snip-id';
		public $dsParamPARAMOUTPUT = 'system:id';
		public $dsParamSORT = 'system:id';
		public $dsParamSTARTPAGE = '1';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';
		
		public $dsParamFILTERS = array(
				'1' => '{$snip-id}',
		);
		
		public $dsParamINCLUDEDELEMENTS = array(
				'title',
				'description',
				'main-xml-file',
				'main-xsl-file',
				'last-update',
				'forked-from'
		);

		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array();
		}
		
		public function about(){
			return array(
					 'name' => 'Snippet Information',
					 'author' => array(
							'name' => 'Marco Sampellegrini',
							'website' => 'http://dev/ninja',
							'email' => 'm@rcosa.mp'),
					 'version' => '1.0',
					 'release-date' => '2010-12-06T09:47:13+00:00');	
		}
		
		public function getSource(){
			return '1';
		}
		
		public function allowEditorToParse(){
			return true;
		}
		
		public function grab(&$param_pool=NULL){
			$result = new XMLElement($this->dsParamROOTELEMENT);
				
			try{
				include(TOOLKIT . '/data-sources/datasource.section.php');
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

