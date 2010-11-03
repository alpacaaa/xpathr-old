<?php

	require_once(TOOLKIT . '/class.event.php');
	require_once(WORKSPACE. '/lib/class.snippet.php');


	class eventsave_resource extends Event{
		
		const ROOTELEMENT = 'save-resource';

		public static function about(){
			return array(
					 'name' => 'Save Resource',
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
		
		public function priority()
		{
			return self::kHIGH;
		}
		
		public function load(){		
			if(isset($_POST['action']['save-snippet'])) return $this->__trigger();
		}
		
		protected function __trigger()
		{
			$url  = $this->_env['env']['url'];
			$snip = $url['snip-id'];
			$user = $url['user'];
			$resource = $url['resource'];

			if (empty($resource)) return;

			$snippet = Snippet::find($snip, $user);
			if (!$snippet) return;

			$resource = $snippet->getResource($resource);
			if (!$resource) return;

			$file = $resource->getFile();
			$data = $_POST['snippet']['resources'][$file];
			$resource->setContent($data['content']);

			$newfilename = $data['filename'];
			if ($newfilename == $file) return $this->saveResource($resource);

			if (!$resource->rename($newfilename))
				return self::buildXML('error', 'Cannot rename resource', $data);

			$type = $resource->getType();
			if ($_POST['fields']['main-'. $type. '-file'] == $file)
				$_POST['fields']['main-'. $type. '-file'] =  $resource->getFile(); //renamed

			$redirect = 'http://'. DOMAIN. '/edit/resource/'. $snip. '/'. $resource->getFile();
			return $this->saveResource($resource, $redirect);
		}		

		public function saveResource(SnippetResource $resource, $redirect = null)
		{
			$status  = 'error';
			$message = 'Cannot save resource';

			if ($resource->save())
			{
				$status  = 'success';
				$message = 'Resource saved';
				if ($redirect)
					$_REQUEST['redirect'] = $redirect;
			}

			return self::buildXML($status, $message);
		}

		public static function buildXML($status, $message, $data = null)
		{
			$result = new XMLElement(self::ROOTELEMENT);
			$result->setAttribute('result', $status);
			$result->appendChild(new XMLElement('message', $message));
			if ($data)
			{
				$result->appendChild(new XMLElement(
					'post-data', $data['content'], array('filename' => $data['filename'])
				));
			}

			return $result;
		}
	}
