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
	}
	
/*----------------------------------------------------------------------------*/
	
	return new BitterFormatNinja();
