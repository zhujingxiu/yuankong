<?php 
class ControllerSaleProjectGroup extends Controller { 
	private $error = array();
   
  	public function index() {
		$this->language->load('sale/project_group');
	
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('sale/project_group');
		
    	$this->getList();
  	}
              
  	public function insert() {
		$this->language->load('sale/project_group');
	
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('sale/project_group');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
      		$this->model_sale_project_group->addProjectGroup($this->request->post);
		  	
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
						
      		$this->redirect($this->url->link('sale/project_group', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
	
    	$this->getForm();
  	}

  	public function update() {
		$this->language->load('sale/project_group');
	
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('sale/project_group');
		
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
	  		$this->model_sale_project_group->editProjectGroup($this->request->get['group_id'], $this->request->post);
			
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
			
			$this->redirect($this->url->link('sale/project_group', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}
	
    	$this->getForm();
  	}

  	public function delete() {
		$this->language->load('sale/project_group');
	
    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('sale/project_group');
		
    	if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $group_id) {
				$this->model_sale_project_group->deleteProjectGroup($group_id);
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
			
			$this->redirect($this->url->link('sale/project_group', 'token=' . $this->session->data['token'] . $url, 'SSL'));
   		}
	
    	$this->getList();
  	}
    
  	protected function getList() {
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'pg.sort_order';
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
			'href'      => $this->url->link('sale/project_group', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
							
		$this->data['insert'] = $this->url->link('sale/project_group/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('sale/project_group/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');	

		$this->data['project_groups'] = array();

		$data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit' => $this->config->get('config_admin_limit')
		);
		$this->load->model('tool/image');
		$project_group_total = $this->model_sale_project_group->getTotalProjectGroups();
	
		$results = $this->model_sale_project_group->getProjectGroups($data);
 
    	foreach ($results as $result) {
			$action = array();
			
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('sale/project_group/update', 'token=' . $this->session->data['token'] . '&group_id=' . $result['group_id'] . $url, 'SSL')
			);
						
			$this->data['project_groups'][] = array(
				'group_id' 			 => $result['group_id'],
				'name'               => $result['name'],
				'keyword'            => $result['keyword'],
				'icon'            	 => $this->model_tool_image->resize($result['icon'],35,35),
				'show'               => $result['show'] ? $this->language->get('text_yes') : $this->language->get('text_no'),
				'sort_order'         => $result['sort_order'],
				'selected'           => isset($this->request->post['selected']) && in_array($result['group_id'], $this->request->post['selected']),
				'action'             => $action
			);
		}	
	
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_keyword'] = $this->language->get('column_keyword');
		$this->data['column_icon'] = $this->language->get('column_icon');
		$this->data['column_show'] = $this->language->get('column_show');
		$this->data['column_sort_order'] = $this->language->get('column_sort_order');
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
		
		$this->data['sort_name'] = $this->url->link('sale/project_group', 'token=' . $this->session->data['token'] . '&sort=pg.name' . $url, 'SSL');
		$this->data['sort_keyword'] = $this->url->link('sale/project_group', 'token=' . $this->session->data['token'] . '&sort=pg.keyword' . $url, 'SSL');
		$this->data['sort_show'] = $this->url->link('sale/project_group', 'token=' . $this->session->data['token'] . '&sort=pg.show' . $url, 'SSL');
		$this->data['sort_sort_order'] = $this->url->link('sale/project_group', 'token=' . $this->session->data['token'] . '&sort=pg.sort_order' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $project_group_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('sale/project_group', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'sale/project_group_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
  	}
  
  	protected function getForm() {
     	$this->data['heading_title'] = $this->language->get('heading_title');

    	$this->data['entry_name'] = $this->language->get('entry_name');
    	$this->data['entry_keyword'] = $this->language->get('entry_keyword');
    	$this->data['entry_show'] = $this->language->get('entry_show');
    	$this->data['entry_icon'] = $this->language->get('entry_icon');
    	$this->data['entry_remark'] = $this->language->get('entry_remark');
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

 		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = '';
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
			'href'      => $this->url->link('sale/project_group', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
		
		if (!isset($this->request->get['group_id'])) {
			$this->data['action'] = $this->url->link('sale/project_group/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('sale/project_group/update', 'token=' . $this->session->data['token'] . '&group_id=' . $this->request->get['group_id'] . $url, 'SSL');
		}
			
		$this->data['cancel'] = $this->url->link('sale/project_group', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['group_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$project_group_info = $this->model_sale_project_group->getProjectGroup($this->request->get['group_id']);
		}
				
	
		if (isset($this->request->post['name'])) {
			$this->data['name'] = $this->request->post['name'];
		} elseif (!empty($project_group_info['name'])) {
			$this->data['name'] = $project_group_info['name'];
		} else {
			$this->data['name'] = '';
		}

		if (isset($this->request->post['keyword'])) {
			$this->data['keyword'] = $this->request->post['keyword'];
		} elseif (!empty($project_group_info['keyword'])) {
			$this->data['keyword'] = $project_group_info['keyword'];
		} else {
			$this->data['keyword'] = '';
		}
		$this->load->model('tool/image');

		$this->data['thumb'] = $this->model_tool_image->resize('no_image.jpg', 35, 35);

		if (isset($this->request->post['icon'])) {
			$this->data['icon'] = $this->request->post['icon'];
		} elseif (!empty($project_group_info['icon'])) {
			$this->data['icon'] = $project_group_info['icon'];
			$this->data['thumb'] = $this->model_tool_image->resize($project_group_info['icon'], 35, 35);
		} else {
			$this->data['icon'] = $this->model_tool_image->resize('no_image.jpg', 35, 35);
		}

		if (isset($this->request->post['show'])) {
			$this->data['show'] = $this->request->post['show'];
		} elseif (!empty($project_group_info['show'])) {
			$this->data['show'] = $project_group_info['show'];
		} else {
			$this->data['show'] = '';
		}

		if (isset($this->request->post['remark'])) {
			$this->data['remark'] = $this->request->post['remark'];
		} elseif (!empty($project_group_info['remark'])) {
			$this->data['remark'] = $project_group_info['remark'];
		} else {
			$this->data['remark'] = '';
		}

		if (isset($this->request->post['sort_order'])) {
			$this->data['sort_order'] = $this->request->post['sort_order'];
		} elseif (!empty($project_group_info['sort_order'])) {
			$this->data['sort_order'] = $project_group_info['sort_order'];
		} else {
			$this->data['sort_order'] = '';
		}
		$this->data['token'] = $this->session->data['token'];
		$this->template = 'sale/project_group_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());	
  	}
  	
	protected function validateForm() {
    	if (!$this->user->hasPermission('modify', 'sale/project_group')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}
	
  		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
    		$this->error['name'] = $this->language->get('error_name');
  		}

  		if ((utf8_strlen($this->request->post['keyword']) < 3) || (utf8_strlen($this->request->post['keyword']) > 64)) {
    		$this->error['keyword'] = $this->language->get('error_keyword');
  		}
    	
		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}
  	}

  	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'sale/project_group')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}
		
		if (!$this->error) { 
	  		return true;
		} else {
	  		return false;
		}
  	}	  
}