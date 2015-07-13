<?php
class ControllerAccountForgotten extends Controller {
	private $error = array();

	public function index() {
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		$this->data['base'] = $server;
		$this->data['description'] = $this->document->getDescription();
		$this->data['keywords'] = $this->document->getKeywords();
		$this->data['links'] = $this->document->getLinks();	 
		$this->data['styles'] = $this->document->getStyles();
		$this->data['scripts'] = $this->document->getScripts();
		$this->data['lang'] = $this->language->get('code');
		$this->data['direction'] = $this->language->get('direction');
		$this->data['google_analytics'] = html_entity_decode($this->config->get('config_google_analytics'), ENT_QUOTES, 'UTF-8');
		$this->data['name'] = $this->config->get('config_name');
		
		if ($this->config->get('config_icon') && file_exists(DIR_IMAGE . $this->config->get('config_icon'))) {
			$this->data['icon'] = $server . TPL_IMG . $this->config->get('config_icon');
		} else {
			$this->data['icon'] = '';
		}
		
		if ($this->config->get('config_logo') && file_exists(DIR_IMAGE . $this->config->get('config_logo'))) {
			$this->data['logo'] = $server . TPL_IMG . $this->config->get('config_logo');
		} else {
			$this->data['logo'] = '';
		}

        $this->data['home'] = $this->url->link('common/home');
		if ($this->customer->isLogged()) {
			$this->redirect($this->url->link('account/account', '', 'SSL'));
		}

		$this->language->load('account/forgotten');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('account/customer');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

		}


		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_your_email'] = $this->language->get('text_your_email');
		$this->data['text_email'] = $this->language->get('text_email');

		$this->data['entry_mobile_phone'] = $this->language->get('entry_mobile_phone');
		$this->data['entry_captcha'] = $this->language->get('entry_captcha');

		$this->data['button_continue'] = $this->language->get('button_continue');
		$this->data['button_back'] = $this->language->get('button_back');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->request->post['mobile_phone'])) {
    		$this->data['mobile_phone'] = $this->request->post['mobile_phone'];
		} else {
			$this->data['mobile_phone'] = '';
		}
		
		$this->data['action'] = $this->url->link('account/forgotten', '', 'SSL');
 
		$this->data['back'] = $this->url->link('account/login', '', 'SSL');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/forgotten.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/forgotten.tpl';
		} else {
			$this->template = 'default/template/account/forgotten.tpl';
		}
		
		$this->children = array(
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/top'	
		);
								
		$this->response->setOutput($this->render());		
	}

	protected function validate() {
		if (!isset($this->request->post['mobile_phone'])) {
			$this->error['warning'] = $this->language->get('error_mobile_phone');
		} elseif (!$this->model_account_customer->getCustomerByMobilePhone($this->request->post['mobile_phone'])) {
			$this->error['warning'] = $this->language->get('error_mobile_phone');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
}
?>