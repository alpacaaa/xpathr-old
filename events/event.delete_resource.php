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
			if (!Snippet::userIsOwner()) return;
			if (!$resource = Snippet::findResourceFromEnv()) return;

			$snippet = Snippet::findFromEnv();

			if ($resource->delete())
			{
				SnippetUser::addFlashMsg('Resource deleted');
				SnippetCache::purge($snippet);

				$user = SnippetUser::getName();
				$snip = $snippet->get('uniq-id');
				$redirect = 'http://'. DOMAIN. '/snippets/'. $user. '/'. $snip. '/';
				redirect($redirect);
			}

			$ex = new SnippetException('Failed to delete resource');
			$result = $ex->getErrorsAsNode(self::ROOTELEMENT);
			return $result;
		}
	}
