<?php  
class ControllerModuleYkcustom extends Controller {
	protected function index($setting) {
		
	
		$description = isset( $setting['description'][$this->config->get('config_language_id')] ) ? $setting['description'][$this->config->get('config_language_id')]:"";
		$title = isset( $setting['title'][$this->config->get('config_language_id')] ) ? $setting['title'][$this->config->get('config_language_id')]:"";
		
		$this->data['message'] = html_entity_decode($description,  ENT_QUOTES, 'UTF-8'  ) ;
		$this->data['title'] = html_entity_decode( $title, ENT_QUOTES, 'UTF-8' );
		$this->data['module_class'] = isset($setting['module_class'])? " ".$setting['module_class']:"";
		$this->template = $this->config->get('config_template') . '/template/module/ykcustom.tpl';
		
		$this->render();
	}
}