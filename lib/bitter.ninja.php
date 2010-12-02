<?php

	require_once 'symphony.php';
	
	class BitterFormatNinja extends BitterFormatSymphony {

		protected function startLine() {
			$this->output .= '<span class="line" id="line-'. $this->line. '">';
			$this->output .= '<span class="marker"></span>';
			$this->output .= '<span class="content">';
		}

		protected function endLine() {
			$this->line++;
			$this->output .= '</span>';
			$this->output .= '</span>';
		}

		protected function processLines() {
			$tokens = preg_split('%(<span class=".*?">|</span>)%', $this->output, 0, PREG_SPLIT_DELIM_CAPTURE);
			$stack = array(); $this->output = '';
			
			$this->startLine();
			
			foreach ($tokens as $token) {
				// Close:
				if (preg_match('%^</%', $token)) {
					array_pop($stack);
					$this->output .= $token;
				}
				
				// Open:
				else if (preg_match('%^<%', $token)) {
					array_push($stack, $token);
					$this->output .= $token;
				}
				
				else {
					$characters = preg_split('//', $token);
					
					foreach ($characters as $character) {
						if ($character == "\n") {
							
							foreach ($stack as $alt_token) $this->output .= '</span>';
							$this->endLine();
						}
						
						$this->output .= $character;
						
						if ($character == "\n") {
							$this->startLine();
							
							foreach ($stack as $alt_token) $this->output .= $alt_token;
						}
					}
				}
			}
			
			$this->endLine();
		}
	}
	
/*----------------------------------------------------------------------------*/

	return new BitterFormatNinja();

/*----------------------------------------------------------------------------*/
