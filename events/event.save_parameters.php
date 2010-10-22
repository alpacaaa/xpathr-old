<?php

	require_once(TOOLKIT . '/class.event.php');
	require_once(WORKSPACE. '/lib/class.snippet.php');


	class eventsave_parameters extends Event{
		
		const ROOTELEMENT = 'save-parameters';

		public static function about(){
			return array(
					 'name' => 'Save Parameters',
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
			if(isset($_POST['action']['save-snippet'])) return $this->__trigger();
		}
		
		protected function __trigger()
		{
			$result = new XMLElement(self::ROOTELEMENT);
			$url  = $this->_env['env']['url'];
			$snip = $url['snip-id'];
			$user = $url['user'];

			$snippet = Snippet::find($snip, $user);
			if (!$snippet) return;

			$data = $_POST['snippet']['parameters'];
			$parameters = $snippet->getParameters();
			$status  = 'success';
			$message = 'Parameters saved';

			try {
				$parameters->setDataFromString($data);
				$parameters->save();
			}
			catch(SnippetParametersException $ex) {
				$status  = 'error';
				$message = $ex->getMessage();
				$result->appendChild(new XMLElement(
					'post-data', htmlentities($data)
				));
			}

			$result->setAttribute('result', $status);
			$result->appendChild(new XMLElement('message', $message));
			return $result;
		}
	}
