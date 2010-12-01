<?php

	require_once(TOOLKIT . '/class.event.php');

	class eventdelete_resource extends Event{
		
		const ROOTELEMENT = 'delete-resource';

		public static function about(){
			return array(
					 'name' => 'Delete Resource',
					 'author' => array(
							'name' => 'Marco Sampellegrini',
							'website' => 'http://192.168.1.57/ninja',
							'email' => 'm@rcosa.mp'),
					 'version' => '1.0',
					 'release-date' => '2010-10-21T15:18:28+00:00',
					 'trigger-condition' => 'action[save-resource]');	
		}

		public static function allowEditorToParse(){
			return false;
		}

		public static function documentation(){
			return '';
		}

		public function load(){		
			if(isset($_POST['action']['delete-resource'])) return $this->__trigger();
		}
		
		protected function __trigger()
		{
			$url  = $this->_env['env']['url'];
			$snip = $url['snip-id'];
			$resource = $url['resource'];

			if (empty($resource)) return;

			$snippet = Snippet::find($snip);
			if (!$snippet || !SnippetUser::owns($snippet)) return;

			$resource = $snippet->getResource($resource);
			if (!$resource) return;

			if ($resource->delete())
			{
				SnippetUser::addFlashMsg('Resource deleted');
				$user = SnippetUser::getName();
				$redirect = 'http://'. DOMAIN. '/snippet/'. $user. '/'. $snip. '/';
				redirect($redirect);
			}

			$result = new XMLElement(self::ROOTELEMENT);
			$result->setAttribute('result', 'error');
			$result->appendChild(new XMLElement('message', 'Failed to delete resource'));
			return $result;
		}
	}
