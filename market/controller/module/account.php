<?php  
class ControllerModuleAccount extends Controller {
	protected function index() {
		$this->language->load('module/account');
		
    	$this->data['heading_title'] = $this->language->get('heading_title');
    	$this->document->addStyle('market/view/theme/' . $this->config->get('config_template') . '/stylesheet/yk_usercenter.css');
		$this->data['text_logout'] = $this->language->get('text_logout');
		$this->data['text_forgotten'] = $this->language->get('text_forgotten');
		$this->data['text_account'] = $this->language->get('text_account');
		$this->data['text_edit'] = $this->language->get('text_edit');
		$this->data['text_password'] = $this->language->get('text_password');
		$this->data['text_address'] = $this->language->get('text_address');
		$this->data['text_wishlist'] = $this->language->get('text_wishlist');
		$this->data['text_order'] = $this->language->get('text_order');
		$this->data['text_return'] = $this->language->get('text_return');
		$this->data['text_transaction'] = $this->language->get('text_transaction');
		
		$this->data['logged'] = $this->customer->isLogged();
		$this->data['logout'] = $this->url->link('account/logout', '', 'SSL');
		$this->data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');
		$this->data['account'] = $this->url->link('account/account', '', 'SSL');
		$this->data['edit'] = $this->url->link('account/edit', '', 'SSL');
		$this->data['password'] = $this->url->link('account/password', '', 'SSL');
		$this->data['address'] = $this->url->link('account/address', '', 'SSL');
		$this->data['helps'] = $this->url->link('account/help');
		$this->data['order'] = $this->url->link('account/order', '', 'SSL');
		$this->data['return'] = $this->url->link('account/return', '', 'SSL');
		$this->data['reviews'] = $this->url->link('account/review', '', 'SSL');
		$this->data['messages'] = $this->url->link('account/message', '', 'SSL');
		$this->data['transaction'] = $this->url->link('account/transaction', '', 'SSL');
		$this->data['description'] = $this->url->link('account/company/description', '', 'SSL');
		$this->data['company'] = $this->url->link('account/company', '', 'SSL');
		$this->data['file'] = $this->url->link('account/company/file', '', 'SSL');
		$this->data['custom1'] = $this->url->link('account/company/custom1', '', 'SSL');
		$this->data['custom2'] = $this->url->link('account/company/custom2', '', 'SSL');
		$this->data['cases'] = $this->url->link('account/company/cases', '', 'SSL');
		$this->data['member'] = $this->url->link('account/company/member', '', 'SSL');
		$this->data['bind'] = $this->url->link('account/bind', '', 'SSL');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/account.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/account.tpl';
		} else {
			$this->template = 'default/template/module/account.tpl';
		}
		
		$this->render();
	}
}