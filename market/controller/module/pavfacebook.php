<?php  
class ControllerModulePavfacebook extends Controller {
	protected function index($setting) {
		static $module = 0;
		
	
		$this->language->load('module/pavfacebook');
		if (file_exists('market/view/theme/' . $this->config->get('config_template') . '/stylesheet/pavfacebook.css')) {
			$this->document->addStyle('market/view/theme/' . $this->config->get('config_template') . '/stylesheet/pavfacebook.css');
		} else {
			$this->document->addStyle('market/view/theme/default/stylesheet/pavfacebook.css');
		}
		
		$this->data = $setting;
		$this->data['displaylanguage'] = $this->language->get('code');
	
		
		
		$this->data['heading_title'] = $this->language->get('heading_title');
		
	
		$this->data['module'] = $module++;
						
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/pavfacebook.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/pavfacebook.tpl';
		} else {
			$this->template = 'default/template/module/pavfacebook.tpl';
		}
		
		$this->render();
	}
}
?>