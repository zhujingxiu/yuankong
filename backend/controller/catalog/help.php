<?php
class ControllerCatalogHelp extends Controller {
	private $error = array();
 
	public function index() {
		$this->language->load('catalog/help');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/help');
		
		$this->getList();
	} 

	public function insert() {
		$this->language->load('catalog/help');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/help');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_tool_faq->addFaq($this->request->post);
			
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
						
			$this->redirect($this->url->link('catalog/help', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function update() {
		$this->language->load('catalog/help');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/help');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_tool_faq->editFaq($this->request->get['faq_id'], $this->request->post);
			
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
						
			$this->redirect($this->url->link('catalog/help', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete() { 
		$this->language->load('catalog/help');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('catalog/help');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $faq_id) {
				$this->model_tool_faq->deleteFaq($faq_id);
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
						
			$this->redirect($this->url->link('catalog/help', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	protected function getList() {
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'f.date_added';
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
			'href'      => $this->url->link('catalog/help', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
							
		$this->data['insert'] = $this->url->link('catalog/help/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('catalog/help/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');	

		$this->data['faqs'] = array();

		$data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit' => $this->config->get('config_admin_limit')
		);
		
		$faq_total = $this->model_tool_faq->getTotalFaqs();
	
		$results = $this->model_tool_faq->getFaqs($data);
 
    	foreach ($results as $result) {
			$action = array();
						
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('catalog/help/update', 'token=' . $this->session->data['token'] . '&faq_id=' . $result['faq_id'] . $url, 'SSL')
			);
						
			$this->data['faqs'][] = array(
				'faq_id'  	 => $result['faq_id'],
				'is_top'     => $result['is_top'],
				'title'      => $result['title'],
				'status'     => ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
				'date_added' => date($this->language->get('date_format_normal'), strtotime($result['date_added'])),
				'selected'   => isset($this->request->post['selected']) && in_array($result['faq_id'], $this->request->post['selected']),
				'action'     => $action
			);
		}	
	
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_top'] = $this->language->get('column_top');
		$this->data['column_title'] = $this->language->get('column_title');
		$this->data['column_status'] = $this->language->get('column_status');
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
		$this->data['sort_top'] = $this->url->link('catalog/help', 'token=' . $this->session->data['token'] . '&sort=f.is_top' . $url, 'SSL');
		$this->data['sort_status'] = $this->url->link('catalog/help', 'token=' . $this->session->data['token'] . '&sort=f.status' . $url, 'SSL');
		$this->data['sort_date_added'] = $this->url->link('catalog/help', 'token=' . $this->session->data['token'] . '&sort=r.date_added' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $faq_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('catalog/help', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'catalog/help_list.tpl';
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
		$this->data['entry_title'] = $this->language->get('entry_title');
		$this->data['entry_top'] = $this->language->get('entry_top');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		
		$this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
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
			'href'      => $this->url->link('catalog/help', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
										
		if (!isset($this->request->get['faq_id'])) { 
			$this->data['action'] = $this->url->link('catalog/help/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('catalog/help/update', 'token=' . $this->session->data['token'] . '&faq_id=' . $this->request->get['faq_id'] . $url, 'SSL');
		}
		
		$this->data['cancel'] = $this->url->link('catalog/help', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['faq_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$faq_info = $this->model_tool_faq->getFaq($this->request->get['faq_id']);
		}
		
		$this->data['token'] = $this->session->data['token'];
			
		foreach ($this->data['languages'] as $language) { 
			if (isset($this->error['title'][$language['language_id']])) {
				$this->data['error_title'][$language['language_id']] = $this->error['title'][$language['language_id']];
			} else {
				$this->data['error_title'][$language['language_id']] = '';
			}
			
	 		if (isset($this->error['text'])) {
				$this->data['error_text'][$language['language_id']] = $this->error['text'][$language['language_id']];
			} else {
				$this->data['error_text'][$language['language_id']] = '';
			}
			
			if (isset($this->request->post['title'][$language['language_id']])) {
				$this->data['title'][$language['language_id']] = $this->request->post['title'][$language['language_id']];
			} elseif (!empty($faq_info[$language['language_id']])) {
				$this->data['title'][$language['language_id']] = $faq_info[$language['language_id']]['title'];
			} else {
				$this->data['title'][$language['language_id']] = '';
			}
	
			if (isset($this->request->post['text'])) {
				$this->data['text'][$language['language_id']] = $this->request->post['text'][$language['language_id']];
			} elseif (!empty($faq_info[$language['language_id']])) {
				$this->data['text'][$language['language_id']] = $faq_info[$language['language_id']]['text'];
			} else {
				$this->data['text'][$language['language_id']] = '';
			}
	
			if (isset($this->request->post['status'][$language['language_id']])) {
				$this->data['status'][$language['language_id']] = $this->request->post['status'][$language['language_id']];
			} elseif (!empty($faq_info[$language['language_id']])) {
				$this->data['status'][$language['language_id']] = $faq_info[$language['language_id']]['status'];
			} else {
				$this->data['status'][$language['language_id']] = '';
			}
	
			if (isset($this->request->post['is_top'][$language['language_id']])) {
				$this->data['is_top'][$language['language_id']] = $this->request->post['is_top'][$language['language_id']];
			} elseif (!empty($faq_info[$language['language_id']])) {
				$this->data['is_top'][$language['language_id']] = $faq_info[$language['language_id']]['is_top'];
			} else {
				$this->data['is_top'][$language['language_id']] = 1;
			}
			
			if (isset($this->request->post['sort_order'][$language['language_id']])) {
				$this->data['sort_order'][$language['language_id']] = $this->request->post['sort_order'][$language['language_id']];
			} elseif (!empty($faq_info[$language['language_id']])) {
				$this->data['sort_order'][$language['language_id']] = $faq_info[$language['language_id']]['sort_order'];
			} else {
				$this->data['sort_order'][$language['language_id']] = '';
			}
		} 
		$this->template = 'catalog/help_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'catalog/help')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if(is_array($this->request->post['title'])){
			foreach ($this->request->post['title'] as $key => $title){
				if ((utf8_strlen($title) < 1) || (utf8_strlen($title) > 512)) {
					$this->error['title'][$key] = $this->language->get('error_title');
				}
			}
		}
		if(is_array($this->request->post['text'])){
			foreach ($this->request->post['text'] as $key => $text){
				if (utf8_strlen($text) < 1) {
					$this->error['text'][$key] = $this->language->get('error_text');
				}
			}
		}
				
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/help')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}	
}