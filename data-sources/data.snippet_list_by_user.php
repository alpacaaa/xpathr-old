<?php

	require_once(TOOLKIT . '/class.datasource.php');
	
	Class datasourcesnippet_list_by_user extends Datasource{
		
		public $dsParamROOTELEMENT = 'snippet-list-by-user';
		public $dsParamORDER = 'desc';
		public $dsParamLIMIT = '10';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'system:id';
		public $dsParamSTARTPAGE = '{$url-page:1}';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';
		
		public $dsParamFILTERS = array(
				'1' => '{$ds-user-snippets}',
				'8' => '{$user}',
		);
		
		public $dsParamINCLUDEDELEMENTS = array(
				'system:pagination',
				'uniq-id',
				'title',
				'description',
				'last-update'
		);

		public function __construct(&$parent, $env=NULL, $process_params=true){
			parent::__construct($parent, $env, $process_params);
			$this->_dependencies = array('$ds-user-snippets');
		}
		
		public function about(){
			return array(
					 'name' => 'Snippet List by user',
					 'author' => array(
							'name' => 'Marco Sampellegrini',
							'website' => 'http://dev/ninja',
							'email' => 'm@rcosa.mp'),
					 'version' => '1.0',
					 'release-date' => '2010-12-01T14:09:32+00:00');	
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

