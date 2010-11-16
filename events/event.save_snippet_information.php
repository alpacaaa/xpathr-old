<?php

	require_once(TOOLKIT . '/class.event.php');

	class eventsave_snippet_information extends Event{
		
		const ROOTELEMENT = 'save-snippet-information';
		
		public $eParamFILTERS = array(
			
		);
			
		public static function about(){
			return array(
					 'name' => 'Save Snippet Information',
					 'author' => array(
							'name' => 'Marco Sampellegrini',
							'website' => 'http://192.168.1.57/ninja',
							'email' => 'm@rcosa.mp'),
					 'version' => '1.0',
					 'release-date' => '2010-10-21T10:10:22+00:00',
					 'trigger-condition' => 'action[save-snippet-information]');	
		}

		public static function getSource(){
			return '1';
		}

		public static function allowEditorToParse(){
			return false;
		}

		public static function documentation(){
			return '';
		}
		
		public function load(){			
			if(isset($_POST['action']['save-snippet'])) return $this->__trigger();
		}
		
		protected function __trigger(){
			$own = $this->processMainResources();
			if (!$own) return;
			include(TOOLKIT . '/events/event.section.php');
			return $result;
		}
		
		protected function processMainResources()
		{
			$url  = $this->_env['env']['url'];
			$snip = $url['snip-id'];
			$user = $url['user'];
			$resource = $url['resource'];

			if (empty($resource)) return;

			$snippet = Snippet::find($snip, $user);
			if (!$snippet || !SnippetOwner::owns($snippet)) return false;

			$resource = $snippet->getResource($resource);
			if (!$resource) return;

			$type = $resource->getType();
			$main = $snippet->isMainResource($resource);
			if ($main && !isset($_POST['snippet']['main-resource'])){
				$_POST['fields']['main-'. $type. '-file'] = '';
				return;
			}

			$_POST['fields']['main-'. $type. '-file'] = $resource->getFile();
			return true;
		}
	}
