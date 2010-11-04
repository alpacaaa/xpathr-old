<?php

	require_once('base.data.snippet_resource.php');

	class datasourcesnippet_resource_encoded extends baseDataSnippetResource{

		public $dsParamROOTELEMENT = 'snippet-resource';

		public function about(){
			return array(
					 'name' => 'Snippet Resource (Encoded)',
					 'author' => array(
							'name' => 'Marco Sampellegrini',
							'website' => 'http://192.168.1.57/ninja',
							'email' => 'm@rcosa.mp'),
					 'version' => '1.0',
					 'release-date' => '2010-10-19T07:59:07+00:00');	
		}

		public function getProcessor(){
			return new EncodedDataProcessor();
		}
	}
