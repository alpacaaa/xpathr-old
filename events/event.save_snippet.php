<?php

	require_once(TOOLKIT . '/class.event.php');
	require_once(WORKSPACE. '/lib/class.snippet.php');


	class eventsave_snippet extends Event{
		
		const ROOTELEMENT = 'save-snippet';
		
		public $eParamFILTERS = array(
			
		);
			
		public static function about()
		{
			return array(
					 'name' => 'Save Snippet',
					 'author' => array(
							'name' => 'Marco Sampellegrini',
							'website' => 'http://alpacaaa.net',
							'email' => 'm@rcosa.mp'),
					 'version' => '1.0',
					 'release-date' => '2010-10-05T10:33:09+00:00'
			);	
		}

		public static function allowEditorToParse()
		{
			return false;
		}

		public static function documentation()
		{
			return '';
		}

		public function load()
		{			
			if(isset($_POST['action']['save-snippet'])) return $this->__trigger();
		}
		
		protected function __trigger()
		{
			$xml  = new XMLElement(self::ROOTELEMENT);
			$env  = $this->_env['env']['url'];
			$user = Snippet::clean($env['user']);
			$snip = Snippet::clean($env['snip-id']);
			$obj  = Snippet::findById($snip, $user);
			if (!$obj) throw new SnippetException('Snippet not found');

			$data = $_POST['snippet']['resources']['parameters'];
			try {
				$obj->saveParameters($data);
			}catch (SnippetException $ex)
			{
				$xml->setValue($data);
				$xml->appendChild(new XMLElement('error', $ex->getMessage()));
			}
			
			return $xml;
		}
	}
