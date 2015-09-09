<?php 
class ControllerCommonHeader extends Controller {
	protected function index() {
		$this->data['title'] = $this->document->getTitle(); 
		
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$this->data['base'] = HTTPS_SERVER;
		} else {
			$this->data['base'] = HTTP_SERVER;
		}
		
		$this->data['description'] = $this->document->getDescription();
		$this->data['keywords'] = $this->document->getKeywords();
		$this->data['links'] = $this->document->getLinks();	
		$this->data['styles'] = $this->document->getStyles();
		$this->data['scripts'] = $this->document->getScripts();
		$this->data['lang'] = $this->language->get('code');
		$this->data['direction'] = $this->language->get('direction');
		
		$this->language->load('common/header');

		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_front'] = $this->language->get('text_front');
		$this->data['text_logout'] = $this->language->get('text_logout');

		if (!$this->user->isLogged() || !isset($this->request->get['token']) || !isset($this->session->data['token']) || ($this->request->get['token'] != $this->session->data['token'])) {
			$this->data['logged'] = '';
			
			$this->data['home'] = $this->url->link('common/login', '', 'SSL');
		} else {
			$profile = $this->url->link('common/profile','token=' . $this->session->data['token'], 'SSL');
			$this->data['logged'] = sprintf($this->language->get('text_logged'), $profile,$this->user->getNickName());
	
			$this->data['home'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');

			$this->data['logout'] = $this->url->link('common/logout', 'token=' . $this->session->data['token'], 'SSL');
			
			$this->data['token']	= $this->session->data['token'];
			$this->data['menu']	= initAdminMenu();
			
			$this->data['text_messages'] = sprintf($this->language->get('text_messages'),0);
			$this->data['text_new_orders'] = sprintf($this->language->get('text_new_orders'),0);
			$this->data['text_new_returns'] = sprintf($this->language->get('text_new_returns'),0);
			$this->data['text_new_projects'] = sprintf($this->language->get('text_new_projects'),0);
			$this->data['text_new_companys'] = sprintf($this->language->get('text_new_companys'),0);
			$this->data['text_new_helps'] = sprintf($this->language->get('text_new_helps'),0);

			$this->data['new_orders'] = $this->url->link('sale/order', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['new_returns'] = $this->url->link('sale/return', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['new_projects'] = $this->url->link('sale/project', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['new_companys'] = $this->url->link('sale/company/request', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['new_helps'] = $this->url->link('extension/help', 'token=' . $this->session->data['token'], 'SSL');
		}
		
		$this->template = 'common/header.tpl';
		
		$this->render();
	}
}