<?php

	require_once(TOOLKIT . '/class.event.php');

	class eventsave_main_resources extends Event{
		
		const ROOTELEMENT = 'save-main-resources';

		public static function about(){
			return array(
					 'name' => 'Save Main Resources',
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
			$url  = $this->_env['env']['url'];
			$snip = $url['snip-id'];
			$user = $url['user'];

			$snippet = Snippet::find($snip, $user);
			if (!$snippet || !SnippetUser::owns($snippet)) return;

			$resources = $snippet->getMainResources();
			if (empty($resources)) return;

			$status  = 'success';
			$message = 'Resources updated correctly';
			$postdata = array();
			foreach ($resources as $resource)
			{
				$data = $_POST['snippet']['resources'][$resource->getFile()];
				$resource->setContent($data['content']);
				if (!$resource->save())
				{
					$status  = 'error';
					$message = 'An error occurred while saving resources';
					$postdata[$resource->getFile()] = $data['content'];
				}
			}

			$result = new XMLElement(self::ROOTELEMENT);
			$result->setAttribute('result', $status);
			$result->appendChild(new XMLElement('message', $message));

			foreach ($postdata as $file => $content)
				$result->appendChild(
					new XMLElement('post-data', $content, array('filename' => $file)
				));

			return $result;
		}
	}
