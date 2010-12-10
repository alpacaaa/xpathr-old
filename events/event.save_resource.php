<?php

	require_once(TOOLKIT . '/class.event.php');

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
			if(isset($_POST['action']['save-snippet'])
			&& isset($_POST['snippet']['resources']))
				return $this->__trigger();
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

			$file = $resource->getFile();
			$data = $_POST['snippet']['resources'][$file];

			if (empty($data['filename']))
				return self::buildXML(
					'error', 'Filename is empty', $data
				);

			$resource->setContent($data['content']);
			$newfilename = $data['filename'];

			$type = $resource->getType();
			if ($data['main-resource'] == 'on')
				$_POST['fields']['main-'. $type. '-file'] =  $resource->getFile();

			try
			{
				if ($newfilename == $file) return $this->saveResource($resource);

				$resource->rename($newfilename);

				if ($_POST['fields']['main-'. $type. '-file'] == $file)
					$_POST['fields']['main-'. $type. '-file'] =  $resource->getFile(); // rename

				$user = SnippetUser::getName();
				$redirect = 'http://'. DOMAIN. '/snippets/'.
					join('/', array($user, $snip, $resource->getFile()));

				return $this->saveResource($resource, $redirect );
			}
			catch(SnippetResourceException $ex)
			{
				return self::buildXML(
					'error', 'Cannot save resource: '. $ex->getMessage(),
					$data + array('file' => $file)
				);
			}
		}

		public function saveResource(SnippetResource $resource, $redirect = null)
		{
			$resource->save();
			SnippetUser::addFlashMsg('Resource saved');
			SnippetCache::purge($resource->getSnippet());

			if ($redirect) $_REQUEST['redirect'] = $redirect;
		}

		public static function buildXML($status, $message, $data = null)
		{
			$result = new XMLElement(self::ROOTELEMENT);
			$result->setAttribute('result', $status);
			$result->appendChild(new XMLElement('message', $message));
			if ($data)
			{
				$result->appendChild(new XMLElement(
					'post-data',
					htmlentities($data['content']),
					array(
						'filename' => $data['filename'], // new filename
						'file' => $data['file'] // old filename
					)
				));
			}

			return $result;
		}
	}
