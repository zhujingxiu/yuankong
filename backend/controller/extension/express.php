<?php 
class ControllerExtensionExpress extends Controller { 
	private $error = array();
   
  	public function index() {
		$this->language->load('extension/express');
	
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('extension/express');
		
    	$this->getList();
  	}
              
  	public function insert() {
		$this->language->load('extension/express');
	
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('extension/express');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
      		$this->model_extension_express->addExpress($this->request->post);
		  	
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
						
      		$this->redirect($this->url->link('extension/express', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
	
    	$this->getForm();
  	}

  	public function update() {
		$this->language->load('extension/express');
	
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('extension/express');
		
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
	  		$this->model_extension_express->editExpress($this->request->get['express_id'], $this->request->post);
			
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
			
			$this->redirect($this->url->link('extension/express', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}
	
    	$this->getForm();
  	}

  	public function delete() {
		$this->language->load('extension/express');
	
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('extension/express');
		
    	if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $express_id) {
				$this->model_extension_express->deleteExpress($express_id);
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
			
			$this->redirect($this->url->link('extension/express', 'token=' . $this->session->data['token'] . $url, 'SSL'));
   		}
	
    	$this->getList();
  	}
    
  	protected function getList() {
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'sort_order';
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
			'href'      => $this->url->link('extension/express', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
							
		$this->data['insert'] = $this->url->link('extension/express/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('extension/express/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');	

		$this->data['expresses'] = array();

		$data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit' => $this->config->get('config_admin_limit')
		);
		$this->load->model('tool/image');
		$express_total = $this->model_extension_express->getTotalExpresss();
	
		$results = $this->model_extension_express->getExpresss($data);
 
    	foreach ($results as $result) {
			$action = array();
			
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('extension/express/update', 'token=' . $this->session->data['token'] . '&express_id=' . $result['express_id'] . $url, 'SSL')
			);
			if(!empty($result['logo'])){
				$logo = $this->model_tool_image->resize($result['logo'], 100, 100);
			}else{
				$logo = '';
			}
			$this->data['expresses'][] = array(
				'express_id' 	=> $result['express_id'],
				'title'         => $result['title'],
				'logo'         	=> $logo,
				'telephone'     => $result['telephone'],
				'sort_order'    => $result['sort_order'],
				'date_added'    => date('Y-m-d H:i:s',strtotime($result['date_added'])),
				'selected'      => isset($this->request->post['selected']) && in_array($result['express_id'], $this->request->post['selected']),
				'action'        => $action
			);
		}	
	
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_title'] = $this->language->get('column_title');
		$this->data['column_telephone'] = $this->language->get('column_telephone');
		$this->data['column_logo'] = $this->language->get('column_logo');
		$this->data['column_sort_order'] = $this->language->get('column_sort_order');
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
		
		$this->data['sort_title'] = $this->url->link('extension/express', 'token=' . $this->session->data['token'] . '&sort=title' . $url, 'SSL');
		$this->data['sort_telephone'] = $this->url->link('extension/express', 'token=' . $this->session->data['token'] . '&sort=telephone' . $url, 'SSL');
		$this->data['sort_date_added'] = $this->url->link('extension/express', 'token=' . $this->session->data['token'] . '&sort=date_added' . $url, 'SSL');		
		$this->data['sort_order'] = $this->url->link('extension/express', 'token=' . $this->session->data['token'] . '&sort=sort_order' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $express_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('extension/express', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'extension/express_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
  	}
  
  	protected function getForm() {
     	$this->data['heading_title'] = $this->language->get('heading_title');

    	$this->data['entry_title'] = $this->language->get('entry_title');
    	$this->data['entry_logo'] = $this->language->get('entry_logo');
    	$this->data['entry_telephone'] = $this->language->get('entry_telephone');
    	$this->data['entry_note'] = $this->language->get('entry_note');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['text_yes'] = $this->language->get('text_yes');
    	$this->data['text_no'] = $this->language->get('text_no');
    	$this->data['text_image_manager'] = $this->language->get('text_image_manager');
 		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['text_clear'] = $this->language->get('text_clear');	

    	$this->data['button_save'] = $this->language->get('button_save');
    	$this->data['button_cancel'] = $this->language->get('button_cancel');
    
 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

 		if (isset($this->error['title'])) {
			$this->data['error_title'] = $this->error['title'];
		} else {
			$this->data['error_title'] = '';
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
			'href'      => $this->url->link('extension/express', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
		
		if (!isset($this->request->get['express_id'])) {
			$this->data['action'] = $this->url->link('extension/express/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('extension/express/update', 'token=' . $this->session->data['token'] . '&express_id=' . $this->request->get['express_id'] . $url, 'SSL');
		}
			
		$this->data['cancel'] = $this->url->link('extension/express', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['express_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$express_info = $this->model_extension_express->getExpress($this->request->get['express_id']);
		}
		$this->load->model('tool/image');		
	
		if (isset($this->request->post['title'])) {
			$this->data['title'] = $this->request->post['title'];
		} elseif (!empty($express_info['title'])) {
			$this->data['title'] = $express_info['title'];
		} else {
			$this->data['title'] = '';
		}

		if (isset($this->request->post['telephone'])) {
			$this->data['telephone'] = $this->request->post['telephone'];
		} elseif (!empty($express_info['telephone'])) {
			$this->data['telephone'] = $express_info['telephone'];
		} else {
			$this->data['telephone'] = '';
		}
		$this->data['thumb'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);

		if (isset($this->request->post['logo'])) {
			$this->data['logo'] = $this->request->post['logo'];
		} elseif (!empty($express_info['logo'])) {
			$this->data['logo'] = $express_info['logo'];
			$this->data['thumb'] = $this->model_tool_image->resize($express_info['logo'], 100, 100);
		} else {
			$this->data['logo'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		}		

		if (isset($this->request->post['note'])) {
			$this->data['note'] = $this->request->post['note'];
		} elseif (!empty($express_info['note'])) {
			$this->data['note'] = $express_info['note'];
		} else {
			$this->data['note'] = '';
		}

		if (isset($this->request->post['sort_order'])) {
			$this->data['sort_order'] = $this->request->post['sort_order'];
		} elseif (!empty($express_info['sort_order'])) {
			$this->data['sort_order'] = $express_info['sort_order'];
		} else {
			$this->data['sort_order'] = 1;
		}
		$this->data['token'] = $this->session->data['token'];
		$this->template = 'extension/express_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());	
  	}
  	
	protected function validateForm() {
    	if (!$this->user->hasPermission('modify', 'extension/express')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}
	
    	
  		if ((utf8_strlen($this->request->post['title']) < 1) || (utf8_strlen($this->request->post['title']) > 64)) {
    		$this->error['title'] = $this->language->get('error_title');
  		}
    	
		
		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}
  	}

  	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'extension/express')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}
		
		if (!$this->error) { 
	  		return true;
		} else {
	  		return false;
		}
  	}	  
}