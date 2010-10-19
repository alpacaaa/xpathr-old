<?php
	
	require_once(TOOLKIT . '/class.datasource.php');
	require_once(WORKSPACE. '/lib/class.snippet.php');


	abstract class baseSnippetDS extends Datasource
	{
		public function allowEditorToParse()
		{
			return false;
		}
		
		public function execute(XMLElement $result)
		{
			$env  = $this->_env['env']['url'];
			$user = Snippet::clean($env['user']);
			$snip = Snippet::clean($env['snip-id']);
			$obj  = Snippet::findById($snip, $user);
			if (!$obj) throw new SnippetException('Snippet not found');

			$info = $obj->getInfo();
			$result->appendChild($info);

			$list = $obj->listResources();
			$all  = new XMLElement('all');
			foreach ($list as $file)
			{
				$resource = $obj->getResource($file);
				$all->appendChild($resource->toXMLElement($empty = true));
			}

			$result->appendChild($all);

			$current  = new XMLElement('current');
			$selected = Snippet::clean($env['resource']);

			if ($selected)
			{
				if ($selected == 'result')
				{
					$process = $obj->process();
					$current->appendChild(
						new XMLElement('result', htmlentities($process))
					);
				}
				elseif ($selected == 'parameters')
				{
					$params = $obj->getParameters();
					$string = '';
					foreach ($params as $k => $v)
						$string .= $k. ' = '. $v. "\n";

					$current->appendChild(
						new XMLElement(
							'resource', $string,
							array('file' => 'parameters')
						)
					);
				}
				elseif ($selected == 'add-resource')
				{
					$current->appendChild(
						new XMLElement(
							'resource', 'paste here',
							array('file' => 'filename.xml')
						)
					);
				}
				else
				{
					$resource = $obj->getResource($selected);
					$current->appendChild($resource->toXMLElement());
				}
			}
			else
			{
				$files = $obj->getMainResources();
				foreach ($files as $f)
				{
					$resource = $obj->getResource($f);
					$current->appendChild($resource->toXMLElement());
				}
			}

			$result->appendChild($current);
			return $result;
		}

		public static function appendError(XMLElement $result, $msg)
		{
			$error = new XMLElement('error', $msg);
			$result->appendChild($error);
			return $result;
		}
	}
