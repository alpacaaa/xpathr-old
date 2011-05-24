<?php

	require_once(TOOLKIT . '/class.event.php');

	class eventfork_snippet extends Event{

		const ROOTELEMENT = 'fork-snippet';

		public static function about(){
			return array(
					 'name' => 'Fork Snippet',
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
			if(isset($_POST['action']['fork-snippet'])) return $this->__trigger();
		}

		protected function __trigger()
		{
			$snippet = Snippet::findFromEnv();
			if (!$snippet) return;

			if ($snip = $snippet->fork())
			{
				SnippetUser::addFlashMsg('Snippet forked');
				SnippetCache::purge($snippet);

				$user = SnippetUser::getName();
				$redirect = 'http://'. DOMAIN. '/snippets/'. $user. '/'. $snip. '/';
				redirect($redirect);
			}

			$ex = new SnippetException('Failed to fork snippet');
			$result = $ex->getErrorsAsNode(self::ROOTELEMENT);
			return $result;
		}
	}