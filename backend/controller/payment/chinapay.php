<?php
class ControllerPaymentchinapay extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('payment/chinapay');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting($this->payment_module_name, $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_all_zones'] = $this->language->get('text_all_zones');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_authorization'] = $this->language->get('text_authorization');
		$this->data['text_sale'] = $this->language->get('text_sale');
		$this->data['text_account_warning'] = $this->language->get('text_account_warning');
		
		$this->data['entry_id'] = $this->language->get('entry_id');
		$this->data['entry_key'] = $this->language->get("entry_key");
	
		$this->data['entry_callback'] = $this->language->get('entry_callback');
		$this->data['entry_total'] = $this->language->get('entry_total');	
		$this->data['entry_area_geo'] = $this->language->get('entry_area_geo');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->error['id'])) {
			$this->data['error_id'] = $this->error['id'];
		} else {
			$this->data['error_id'] = '';
		}
		
		if (isset($this->error['key'])) {
			$this->data['error_key'] = $this->error['key'];
		} else {
			$this->data['error_key'] = '';
		}

	

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),      		
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_payment'),
			'href'      => $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('payment/chinapay', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['action'] = $this->url->link('payment/chinapay', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['chinapay_id'])) {
			$this->data['chinapay_id'] = $this->request->post['chinapay_id'];
		} else {
			$this->data['chinapay_id'] = $this->config->get('chinapay_id');
		}

		if (isset($this->request->post['chinapay_key'])) {
			$this->data['chinapay_key'] = $this->request->post['chinapay_key'];
		} else {
			$this->data['chinapay_key'] = $this->config->get('chinapay_key');
		}

	

		$this->data['callback'] = HTTP_CATALOG . 'index.php?route=payment/chinapay/callback';

		if (isset($this->request->post['chinapay_total'])) {
			$this->data['chinapay_total'] = $this->request->post['chinapay_total'];
		} else {
			$this->data['chinapay_total'] = $this->config->get('chinapay_total'); 
		} 

		$this->load->model('localisation/order_status');

		$this->data['order_statuses'] = $this->model_localisation_order_status->getOrderStatuses();

		if (isset($this->request->post['chinapay_area_geo_id'])) {
			$this->data['chinapay_area_geo_id'] = $this->request->post['chinapay_area_geo_id'];
		} else {
			$this->data['chinapay_area_geo_id'] = $this->config->get('chinapay_area_geo_id');
		}

		$this->load->model('localisation/area_geo');

		$this->data['area_geos'] = $this->model_localisation_area_geo->getAreaGeos();

		if (isset($this->request->post['chinapay_status'])) {
			$this->data['chinapay_status'] = $this->request->post['chinapay_status'];
		} else {
			$this->data['chinapay_status'] = $this->config->get('chinapay_status');
		}

		if (isset($this->request->post['chinapay_sort_order'])) {
			$this->data['chinapay_sort_order'] = $this->request->post['chinapay_sort_order'];
		} else {
			$this->data['chinapay_sort_order'] = $this->config->get('chinapay_sort_order');
		}

		$this->template = 'payment/chinapay.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		$this->response->setOutput($this->render());
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'payment/chinapay')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->request->post['chinapay_id']) {
			$this->error['id'] = $this->language->get('error_id');
		}

		if (!$this->request->post['chinapay_key']) {
			$this->error['key'] = $this->language->get('error_key');
		}
		


		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
}
?>