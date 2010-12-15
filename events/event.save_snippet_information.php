<?php

	require_once(TOOLKIT . '/class.event.php');

	class eventsave_snippet_information extends Event{

		const ROOTELEMENT = 'save-snippet-information';


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
			if (!Snippet::userIsOwner()) return;
			$snippet = Snippet::findFromEnv();

			SnippetCache::purge($snippet);

			unset($_POST['fields']['user']);
			unset($_POST['fields']['forked-from']);
			$_POST['fields']['last-update'] = ''; //forcing update

			if ($_POST['fields']['title'])
				$_POST['fields']['title'] = substr($_POST['fields']['title'], 0, 40);

			if ($_POST['fields']['description'])
				$_POST['fields']['description'] = substr($_POST['fields']['description'], 0, 450);

			Snippet::reload();

			include(TOOLKIT . '/events/event.section.php');
			return $result;
		}
	}
