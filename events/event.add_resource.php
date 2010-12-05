<?php

	require_once(TOOLKIT . '/class.event.php');

	class eventadd_resource extends Event{
		
		const ROOTELEMENT = 'add-resource';

		public static function about(){
			return array(
					 'name' => 'Add Resource',
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
		
		public function load()
		{
			if (!$this->getSnippet())
				throw new FrontendPageNotFoundException();

			if (isset($_POST['action']['save-snippet'])) return $this->__trigger();
		}
		
		protected function __trigger()
		{
			$snippet = $this->getSnippet();
			if (!$snippet) return;

			$data = $_POST['snippet']['new-resource'];
			$file = SnippetResource::clean($data['filename']);

			if (empty($file))
				return self::buildXML(
					'Filename is empty', $data
				);

			if (is_object($snippet->getResource($file)))
				return self::buildXML('Resource already exists', $data);

			$resource = new SnippetResource($file, $snippet);
			$resource->setContent($data['content']);

			if ($resource->save())
			{
				$user = SnippetUser::getName();
				$redirect = 'http://'. DOMAIN. '/snippet/resource/'. 
					join('/', array($user, $snippet->get('uniq-id'), $resource->getFile()));

				$_REQUEST['redirect'] = $redirect;
				SnippetUser::addFlashMsg('Resource created');

				$type = $resource->getType();
				if ($data['main-resource'] == 'on')
					$_POST['fields']['main-'. $type. '-file'] =  $resource->getFile();

				return;
			}

			return self::buildXML('Failed to save resource', $data);
		}
		
		public static function buildXML($message, $data)
		{
			$result = new XMLElement(self::ROOTELEMENT);
			$result->setAttribute('result', 'error');
			$result->appendChild(new XMLElement('message', $message));
			$result->appendChild(new XMLElement(
				'post-data', htmlentities($data['content']), array('filename' => $data['filename'])
			));

			return $result;
		}

		public function getSnippet()
		{
			$url  = $this->_env['env']['url'];
			$snip = $url['snip-id'];

			$snippet = Snippet::find($snip);
			if (!$snippet || !SnippetUser::owns($snippet)) return false;

			return $snippet;
		}
	}
