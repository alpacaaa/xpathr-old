<?php

	require_once(TOOLKIT . '/class.event.php');

	class eventnew_snippet extends Event{

		const ROOTELEMENT = 'new-snippet';

		public static function about(){
			return array(
					 'name' => 'New Snippet',
					 'author' => array(
							'name' => 'Marco Sampellegrini',
							'website' => 'http://192.168.1.57/ninja',
							'email' => 'm@rcosa.mp'),
					 'version' => '1.0',
					 'release-date' => '2010-11-16T15:18:28+00:00');	
		}

		public static function allowEditorToParse(){
			return false;
		}

		public static function documentation(){
			return '';
		}

		public function load(){		
			if(isset($_POST['action']['new-snippet'])) return $this->__trigger();
		}

		protected function __trigger()
		{
			if ($snip = Snippet::createNew())
			{
				SnippetUser::addFlashMsg('Snippet created');
				$user = SnippetUser::getName();
				$redirect = 'http://'. DOMAIN. '/snippet/'. $user. '/'. $snip. '/';
				//redirect($redirect);
			}

			return new XMLElement(
				self::ROOTELEMENT, 'Failed to create snippet',
				array('result' => 'error')
			);
		}
	}
