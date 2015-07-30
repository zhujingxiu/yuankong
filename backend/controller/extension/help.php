<?php
class ControllerExtensionHelp extends Controller {
	private $error = array();
 
	public function index() {
		$this->language->load('extension/help');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('extension/help');
		
		$this->getList();
	} 

	public function insert() {
		$this->language->load('extension/help');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('extension/help');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_extension_help->addHelp($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
						
			$this->redirect($this->url->link('extension/help', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function update() {
		$this->language->load('extension/help');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('extension/help');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_extension_help->editHelp($this->request->get['help_id'], $this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
						
			$this->redirect($this->url->link('extension/help', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete() { 
		$this->language->load('extension/help');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('extension/help');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $help_id) {
				$this->model_extension_help->deleteHelp($help_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
						
			$this->redirect($this->url->link('extension/help', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	protected function getList() {
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'h.date_added';
		}
		
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
				
		$url = '';
			
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/help', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
							
		$this->data['insert'] = $this->url->link('extension/help/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('extension/help/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');	

		$this->data['helps'] = array();

		$data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit' => $this->config->get('config_admin_limit')
		);
		
		$help_total = $this->model_extension_help->getTotalHelps();
	
		$results = $this->model_extension_help->getHelps($data);
 
    	foreach ($results as $result) {
			$action = array();
						
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('extension/help/update', 'token=' . $this->session->data['token'] . '&help_id=' . $result['help_id'] . $url, 'SSL')
			);
						
			$this->data['helps'][] = array(
				'help_id'  	 => $result['help_id'],
				'top'     	 => $result['is_top'] ? $this->language->get('text_yes') : $this->language->get('text_no'),
				'account'    => $result['account'],
				'telephone'  => $result['telephone'],
				'text'  => $result['text'],
				'status'     => $result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled'),
				'reply'      => empty($result['reply']) ? $this->language->get('text_unreply') : $this->language->get('text_replied'),
				'date_added' => date('Y-m-d H:i:s', strtotime($result['date_added'])),
				'selected'   => isset($this->request->post['selected']) && in_array($result['help_id'], $this->request->post['selected']),
				'action'     => $action
			);
		}	
	
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_top'] = $this->language->get('column_top');
		$this->data['column_account'] = $this->language->get('column_account');
		$this->data['column_telephone'] = $this->language->get('column_telephone');
		$this->data['column_text'] = $this->language->get('column_text');
		$this->data['column_reply'] = $this->language->get('column_reply');
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_action'] = $this->language->get('column_action');		
		
		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_delete'] = $this->language->get('button_delete');
 
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		$this->data['sort_account'] = $this->url->link('extension/help', 'token=' . $this->session->data['token'] . '&sort=h.account' . $url, 'SSL');
		$this->data['sort_telephone'] = $this->url->link('extension/help', 'token=' . $this->session->data['token'] . '&sort=h.telephone' . $url, 'SSL');
		$this->data['sort_top'] = $this->url->link('extension/help', 'token=' . $this->session->data['token'] . '&sort=h.is_top' . $url, 'SSL');
		$this->data['sort_status'] = $this->url->link('extension/help', 'token=' . $this->session->data['token'] . '&sort=h.status' . $url, 'SSL');
		$this->data['sort_date_added'] = $this->url->link('extension/help', 'token=' . $this->session->data['token'] . '&sort=h.date_added' . $url, 'SSL');
		$this->data['sort_date_replied'] = $this->url->link('extension/help', 'token=' . $this->session->data['token'] . '&sort=h.date_replied' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $help_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('extension/help', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'extension/help_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}

	protected function getForm() {
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_none'] = $this->language->get('text_none');
		$this->data['text_select'] = $this->language->get('text_select');

		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_text'] = $this->language->get('entry_text');
		$this->data['entry_account'] = $this->language->get('entry_account');
		$this->data['entry_telephone'] = $this->language->get('entry_telephone');
		$this->data['entry_reply'] = $this->language->get('entry_reply');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_top'] = $this->language->get('entry_top');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
 		if (isset($this->error['account'])) {
			$this->data['error_account'] = $this->error['account'];
		} else {
			$this->data['error_account'] = '';
		}
		if (isset($this->error['telephone'])) {
			$this->data['error_telephone'] = $this->error['telephone'];
		} else {
			$this->data['error_telephone'] = '';
		}
		if (isset($this->error['text'])) {
			$this->data['error_text'] = $this->error['text'];
		} else {
			$this->data['error_text'] = '';
		}
		if (isset($this->error['reply'])) {
			$this->data['error_reply'] = $this->error['reply'];
		} else {
			$this->data['error_reply'] = '';
		}
		$url = '';
			
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
				
   		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/help', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
										
		if (!isset($this->request->get['help_id'])) { 
			$this->data['action'] = $this->url->link('extension/help/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('extension/help/update', 'token=' . $this->session->data['token'] . '&help_id=' . $this->request->get['help_id'] . $url, 'SSL');
		}
		
		$this->data['cancel'] = $this->url->link('extension/help', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['help_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$help_info = $this->model_extension_help->getHelp($this->request->get['help_id']);
		}
		
		$this->data['token'] = $this->session->data['token'];
			
		if (isset($this->request->post['account'])) {
			$this->data['account'] = $this->request->post['account'];
		} elseif (!empty($help_info['account'])) {
			$this->data['account'] = $help_info['account'];
		} else {
			$this->data['account'] = '';
		}

		if (isset($this->request->post['telephone'])) {
			$this->data['telephone'] = $this->request->post['telephone'];
		} elseif (!empty($help_info['telephone'])) {
			$this->data['telephone'] = $help_info['telephone'];
		} else {
			$this->data['telephone'] = '';
		}

		if (isset($this->request->post['text'])) {
			$this->data['text'] = $this->request->post['text'];
		} elseif (!empty($help_info['text'])) {
			$this->data['text'] = $help_info['text'];
		} else {
			$this->data['text'] = '';
		}

		if (isset($this->request->post['reply'])) {
			$this->data['reply'] = $this->request->post['reply'];
		} elseif (!empty($help_info['reply'])) {
			$this->data['reply'] = $help_info['reply'];
		} else {
			$this->data['reply'] = '';
		}

		if (isset($this->request->post['status'])) {
			$this->data['status'] = $this->request->post['status'];
		} elseif (!empty($help_info['status'])) {
			$this->data['status'] = $help_info['status'];
		} else {
			$this->data['status'] = 1;
		}

		if (isset($this->request->post['is_top'])) {
			$this->data['is_top'] = $this->request->post['is_top'];
		} elseif (!empty($help_info['is_top'])) {
			$this->data['is_top'] = $help_info['is_top'];
		} else {
			$this->data['is_top'] = '';
		}

		if (isset($this->request->post['sort_order'])) {
			$this->data['sort_order'] = $this->request->post['sort_order'];
		} elseif (!empty($help_info['sort_order'])) {
			$this->data['sort_order'] = $help_info['sort_order'];
		} else {
			$this->data['sort_order'] = 1;
		}
		$this->template = 'extension/help_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'extension/help')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		
		if ((utf8_strlen($this->request->post['account']) < 1) || (utf8_strlen($this->request->post['account']) > 64)) {
			$this->error['account'] = $this->language->get('error_account');
		}
		if ((utf8_strlen($this->request->post['telephone']) < 1) || (utf8_strlen($this->request->post['telephone']) > 32)) {
			$this->error['telephone'] = $this->language->get('error_telephone');
		}
		if (utf8_strlen($this->request->post['text']) < 1) {
			$this->error['text'] = $this->language->get('error_text');
		}
		if (utf8_strlen($this->request->post['reply']) < 1) {
			$this->error['reply'] = $this->language->get('error_reply');
		}
				
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'extension/help')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}	
}