<?php
class Controllerpaymentalipaydirect extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('payment/alipay_direct');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			
			$this->model_setting_setting->editSetting('alipay_direct', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_edit'] = $this->language->get('text_edit');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_all_zones'] = $this->language->get('text_all_zones');
		
		$this->data['entry_partner_id_help'] = $this->language->get('entry_partner_id_help');
		$this->data['entry_partner_id'] = $this->language->get('entry_partner_id');
		
		$this->data['entry_account'] = $this->language->get('entry_account');
		

		$this->data['entry_order_status'] = $this->language->get('entry_order_status');
		
		
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['entry_cod'] = $this->language->get('entry_cod');
		$this->data['entry_cod_help'] = $this->language->get('entry_cod_help');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_payment'),
			'href' => $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('payment/alipay_direct', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['action'] = $this->url->link('payment/alipay_direct', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');
		
		if (isset($this->error['alipay_direct_partner_id'])) {
			$this->data['error_alipay_direct_partner_id'] = $this->error['alipay_direct_partner_id'];
		} else {
			$this->data['error_alipay_direct_partner_id'] = '';
		}	
		
		
		if (isset($this->error['alipay_direct_account'])) {
			$this->data['error_alipay_direct_account'] = $this->error['alipay_direct_account'];
		} else {
			$this->data['error_alipay_direct_account'] = '';
		}	
		
		
		if (isset($this->error['alipay_direct_cod'])) {
			$this->data['error_alipay_direct_cod'] = $this->error['alipay_direct_cod'];
		} else {
			$this->data['error_alipay_direct_cod'] = '';
		}	
		
		
		//合作身份者id
		if (isset($this->request->post['alipay_direct_partner_id'])) {
			$this->data['alipay_direct_partner_id'] = $this->request->post['alipay_direct_partner_id'];
		} else {
			$this->data['alipay_direct_partner_id'] = $this->config->get('alipay_direct_partner_id');
		}
		
		//收款支付宝账号
		if (isset($this->request->post['alipay_direct_account'])) {
			$this->data['alipay_direct_account'] = $this->request->post['alipay_direct_account'];
		} else {
			$this->data['alipay_direct_account'] = $this->config->get('alipay_direct_account');
		}
		
		//安全检验码
		if (isset($this->request->post['alipay_direct_cod'])) {
			$this->data['alipay_direct_cod'] = $this->request->post['alipay_direct_cod'];
		} else {
			$this->data['alipay_direct_cod'] = $this->config->get('alipay_direct_cod');
		}
		
		//成功支付后的订单状态
		if (isset($this->request->post['alipay_direct_order_status_id'])) {
			$this->data['alipay_direct_order_status_id'] = $this->request->post['alipay_direct_order_status_id'];
		} else {
			$this->data['alipay_direct_order_status_id'] = $this->config->get('alipay_direct_order_status_id');
		}

		$this->load->model('localisation/order_status');

		$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

		
		//状态
		if (isset($this->request->post['alipay_direct_status'])) {
			$this->data['alipay_direct_status'] = $this->request->post['alipay_direct_status'];
		} else {
			$this->data['alipay_direct_status'] = $this->config->get('alipay_direct_status');
		}
		
		//排序
		if (isset($this->request->post['alipay_direct_sort_order'])) {
			$this->data['alipay_direct_sort_order'] = $this->request->post['alipay_direct_sort_order'];
		} else {
			$this->data['alipay_direct_sort_order'] = $this->config->get('alipay_direct_sort_order');
		}
		$this->template = 'payment/alipay_direct.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'payment/alipay_direct')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		//合作身份者id
		if (!$this->request->post['alipay_direct_partner_id']) {
			$this->error['alipay_direct_partner_id'] = $this->language->get('error_alipay_direct_partner_id');
		}
		
		//收款支付宝账号
		if (!$this->request->post['alipay_direct_account']) {
			$this->error['alipay_direct_account'] = $this->language->get('error_alipay_direct_account');
		}
		
		//安全检验码
		if (!$this->request->post['alipay_direct_cod']) {
			$this->error['alipay_direct_cod'] = $this->language->get('error_alipay_direct_cod');
		}

		return !$this->error;
	}
}