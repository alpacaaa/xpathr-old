<?php

	require_once(EXTENSIONS. '/ninja/lib/class.snippet.php');

	class extension_Ninja extends Extension
	{
		public function about() {
			return array(
				'name' => 'XPath Ninja',
				'version' => '1.0',
				'release-date' => '2010-11-16',
				'author' => array(
					'name' => 'Marco Sampellegrini',
					'email' => 'm@rcosa.mp'
				)
			);
		}
	}
