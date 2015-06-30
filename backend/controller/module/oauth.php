<?php
class ControllerModuleOauth extends Controller {
	private $error = array(); 

	public function index() {   
		$this->language->load('module/oauth');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');
		$this->load->model('tool/image');
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('oauth', $this->request->post);		

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');		
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
        $this->data['text_browse'] = $this->language->get('text_browse');
        $this->data['text_clear'] = $this->language->get('text_clear'); 
        $this->data['no_image'] = '';

		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_client_id'] = $this->language->get('entry_client_id');
		$this->data['entry_client_secret'] = $this->language->get('entry_client_secret');
		$this->data['entry_img'] = $this->language->get('entry_img');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_c_email'] = $this->language->get('entry_c_email');
		$this->data['entry_c_name'] = $this->language->get('entry_c_name');
		$this->data['entry_c_nickname'] = $this->language->get('entry_c_nickname');
		$this->data['entry_c_openid'] = $this->language->get('entry_c_openid');
		$this->data['entry_c_date'] = $this->language->get('entry_c_date');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');

		$this->data['tab_module'] = $this->language->get('tab_module');
		
		$this->data['error_jump'] = $this->language->get('error_jump');

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/oauth', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['delete'] = html_entity_decode($this->url->link('module/oauth/delete', 'token=' . $this->session->data['token'], 'SSL'), ENT_QUOTES, 'UTF-8');
		$this->data['action'] = $this->url->link('module/oauth', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['token'] = $this->session->data['token'];

		$this->data['oauth'] = array();

		if (isset($this->request->post['oauth'])) {
			$this->data['oauth'] = $this->request->post['oauth'];
		} elseif ($this->config->get('oauth')) { 
			$this->data['oauth'] = $this->config->get('oauth');
		} else {
			$this->data['oauth'] = '';
		}
		
		$this->load->model('module/oauth');
		
		$page = 1; $limit = 10;
		
		$data = array(
			'start'    => ($page - 1) * $limit,
			'limit'    => $limit
		);
		
		$oauths = $this->model_module_oauth->getOauths($data);
		
		$this->data['oauth_list'] = array();
		
		if ($oauths) {
			foreach ($oauths as $oauth) {
				$this->data['oauth_list'][] = array(
					'oauth_id'       => $oauth['oauth_id'],
					'customer_id'    => $oauth['customer_id'],
					'openid'         => $oauth['openid'],
					'type'           => $oauth['type'],
					'token'          => $oauth['token'],
					'expired'        => $oauth['expired'],
					'name'           => $oauth['name'],
					'face'           => $oauth['face'],
					'date_added'     => date('Y-m-d', strtotime($oauth['date_added'])),
					'date_updated'   => $oauth['date_updated'],
					'firstname'      => $oauth['firstname'],
					'lastname'       => $oauth['lastname'],
					'email'          => $oauth['email'],
					'href'           => $this->url->link('sale/customer/update', 'customer_id='.$oauth['customer_id'].'&token=' . $this->session->data['token'], 'SSL'),
				);
			}
		}
			
		$totalOauths = $this->model_module_oauth->getTotalOauths($data);
	
		$total = $totalOauths;
		$total_pages = ceil($total / $limit);
		$now_page    = $page < 1 ? 1 : $page;
		$next_page   = $now_page + 1;
		$prev_page   = $now_page - 1;
		
		$pagination  = '';
		$paget_text = '';
		
		if ($now_page > 1) {
			$paget_text .= '<a onclick="show('.$prev_page.');" title="Prev"><i class="btn_prev"></i></a>';
		}
		
			$paget_text .= '<b>'.$now_page.'/'.$total_pages.'</b>';
		
		if ($total_pages > 1 && $now_page != $total_pages) {
			$paget_text .= '<a onclick="show('.$next_page.');" title="Next"><i class="btn_next"></i></a>';
		}
		
		$pagination .= '<div class="links">'.$paget_text.'</div>';
		
		$this->data['pagination'] = $pagination;
		$this->data['maxpage'] = $total_pages;

		$this->load->model('design/layout');

		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$this->load->model('localisation/language');

		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->template = 'module/oauth.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	public function getlist() {
		$json = array();
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		
		if (isset($this->request->get['limit'])) {
			$limit = $this->request->get['limit'];
		} else {
			$limit = 10;
		}
		
		$this->load->model('module/oauth');
		
		$data = array(
			'start'    => ($page - 1) * $limit,
			'limit'    => $limit
		);
		
		$oauths = $this->model_module_oauth->getOauths($data);
		
		$json['data'] = array();
		$json['pagination'] = '';
		
		if ($oauths) {
			foreach ($oauths as $oauth) {
				$json['data'][] = array(
					'oauth_id'       => $oauth['oauth_id'],
					'customer_id'    => $oauth['customer_id'],
					'openid'         => $oauth['openid'],
					'type'           => $oauth['type'],
					'token'          => $oauth['token'],
					'expired'        => $oauth['expired'],
					'name'           => $oauth['name'],
					'face'           => $oauth['face'],
					'date_added'     => date('Y-m-d', strtotime($oauth['date_added'])),
					'date_updated'   => $oauth['date_updated'],
					'firstname'      => $oauth['firstname'],
					'lastname'       => $oauth['lastname'],
					'email'          => $oauth['email'],
					'href'           => $this->url->link('sale/customer/update', 'customer_id='.$oauth['customer_id'].'&token=' . $this->session->data['token'], 'SSL'),
				);
			}
			
			$totalOauths = $this->model_module_oauth->getTotalOauths($data);
		
			$total = $totalOauths;
			$total_pages = ceil($total / $limit);
			$now_page    = $page < 1 ? 1 : $page;
			$next_page   = $now_page + 1;
			$prev_page   = $now_page - 1;
			
			$pagination  = '';
			$paget_text = '';
		
			if ($now_page > 1) {
				$paget_text .= '<a onclick="show('.$prev_page.');" title="Prev"><i class="btn_prev"></i></a>';
			}
			
				$paget_text .= '<b>'.$now_page.'/'.$total_pages.'</b>';
			
			if ($total_pages > 1 && $now_page != $total_pages) {
				$paget_text .= '<a onclick="show('.$next_page.');" title="Next"><i class="btn_next"></i></a>';
			}
			
			$pagination .= '<div class="links">'.$paget_text.'</div>';
			
			$json['pagination'] = $pagination;
		}
		
		$this->response->setOutput(json_encode($json));
	}
	
	public function delete() {
		$json = array();
		$this->language->load('module/oauth');
		
		if (isset($this->request->post['selected']) && $this->validate()) {
			$this->load->model('module/oauth');
			
			foreach ($this->request->post['selected'] as $oauth_id) {
				$this->model_module_oauth->deleteOauth($oauth_id);
			}

			$json['success'] = $this->language->get('success_delete');
		} else {
			$json['error'] = $this->language->get('error_delete');
		}
		
		$this->response->setOutput(json_encode($json));
	}

	public function install() {
		$this->load->model('module/oauth');
		$this->model_module_oauth->install();
	}

	public function uninstall() {
		$this->load->model('module/oauth');
		$this->model_module_oauth->uninstall();
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/oauth')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}