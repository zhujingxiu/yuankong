<?php    
class ControllerExtensionCase extends Controller { 
	private $error = array();
  
  	public function index() {
		$this->language->load('extension/case');
		
		$this->document->setTitle($this->language->get('heading_title'));
		 
		$this->load->model('extension/case');
		
    	$this->getList();
  	}
  
  	public function insert() {
		$this->language->load('extension/case');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('extension/case');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {

			$this->model_extension_case->addCase($this->request->post);

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
			
			$this->redirect($this->url->link('extension/case', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    
    	$this->getForm();
  	} 
   
  	public function update() {
		$this->language->load('extension/case');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('extension/case');
		
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_extension_case->editCase($this->request->get['case_id'], $this->request->post);

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
			
			$this->redirect($this->url->link('extension/case', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    
    	$this->getForm();
  	}   

  	public function delete() {
		$this->language->load('extension/case');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('extension/case');
			
    	if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $case_id) {
				$this->model_extension_case->deleteCase($case_id);
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
			
			$this->redirect($this->url->link('extension/case', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}
	
    	$this->getList();
  	}  
    
  	protected function getList() {
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'name';
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
			'href'      => $this->url->link('extension/case', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
							
		$this->data['insert'] = $this->url->link('extension/case/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('extension/case/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');	

		$this->data['cases'] = array();

		$data = array(
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit' => $this->config->get('config_admin_limit')
		);
		
		$case_total = $this->model_extension_case->getTotalCases();
	
		$results = $this->model_extension_case->getCases($data);
 		$this->load->model('tool/image');

    	foreach ($results as $result) {
			$action = array();
			
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('extension/case/update', 'token=' . $this->session->data['token'] . '&case_id=' . $result['case_id'] . $url, 'SSL')
			);
		 	if(file_exists(DIR_IMAGE . $result['cover'])){
		 		$image =  $result['cover'];
		 	}else{
		 		$image = 'no_image.jpg';
		 	}
			$this->data['cases'][] = array(
				'case_id' 	=> $result['case_id'],
				'name'      => $result['name'],
				'cover' 	=> $this->model_tool_image->resize($image, 100, 100),
				'images' 	=> $this->model_extension_case->getTotalCaseImages($result['case_id']),
				'sort_order' => $result['sort_order'],
				'selected'        => isset($this->request->post['selected']) && in_array($result['case_id'], $this->request->post['selected']),
				'action'          => $action
			);
		}	
	
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_cover'] = $this->language->get('column_cover');
		$this->data['column_images'] = $this->language->get('column_images');
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
		
		$this->data['sort_name'] = $this->url->link('extension/case', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
		$this->data['sort_sort_order'] = $this->url->link('extension/case', 'token=' . $this->session->data['token'] . '&sort=sort_order' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $case_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('extension/case', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'extension/case_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
  
  	protected function getForm() {
    	$this->data['heading_title'] = $this->language->get('heading_title');
    	$this->document->addScript('view/javascript/jquery/ajaxupload.js');
    	$this->document->addScript('view/javascript/ckeditor/ckeditor.js');
    	$this->document->addScript(TPL_JS.'jquery.json.min.js');
    	$this->document->addStyle(TPL_JS.'fancybox/jquery.fancybox.css?v=2.1.5');
        $this->document->addScript(TPL_JS.'fancybox/jquery.fancybox.pack.js?v=2.1.5');
        $this->document->addStyle(TPL_JS.'fancybox/helpers/jquery.fancybox-buttons.css?v=2.1.5');
        $this->document->addScript(TPL_JS.'fancybox/helpers/jquery.fancybox-buttons.js?v=2.1.5');
        $this->document->addStyle(TPL_JS.'fancybox/helpers/jquery.fancybox-thumbs?v=2.1.5');
        $this->document->addScript(TPL_JS.'fancybox/helpers/jquery.fancybox-thumbs.js?v=2.1.5');
    	$this->data['text_enabled'] = $this->language->get('text_enabled');
    	$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_default'] = $this->language->get('text_default');
    	$this->data['text_image_manager'] = $this->language->get('text_image_manager');
		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['text_clear'] = $this->language->get('text_clear');			
		$this->data['tab_images'] = $this->language->get('tab_images');
		$this->data['text_delete'] = $this->language->get('text_delete');
				
		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_desc'] = $this->language->get('entry_desc');
		$this->data['entry_keyword'] = $this->language->get('entry_keyword');
    	$this->data['entry_cover'] = $this->language->get('entry_cover');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['entry_add_img'] = $this->language->get('entry_add_img');
		  
    	$this->data['button_save'] = $this->language->get('button_save');
    	$this->data['button_cancel'] = $this->language->get('button_cancel');
		
		$this->data['tab_general'] = $this->language->get('tab_general');
			  
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
			'href'      => $this->url->link('extension/case', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
							
		if (!isset($this->request->get['case_id'])) {
			$this->data['action'] = $this->url->link('extension/case/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('extension/case/update', 'token=' . $this->session->data['token'] . '&case_id=' . $this->request->get['case_id'] . $url, 'SSL');
		}
		$this->load->model('tool/image');
		$this->data['cancel'] = $this->url->link('extension/case', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$file = array();
    	if (isset($this->request->get['case_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
      		$case_info = $this->model_extension_case->getCase($this->request->get['case_id']);
      		$case_images = $this->model_extension_case->getCaseImages($this->request->get['case_id']);
      		foreach ($case_images as $attch) {
      			if ($attch['path'] && file_exists($attch['path'])) {
	                $file[] = array(
	                	'realpath' => HTTP_CATALOG.substr($attch['path'],strpos($attch['path'],'/')+1),
	                	'name' => $attch['name'],
	                	'image' => $this->model_tool_image->resize($attch['path'], 100, 100,true),
	                );
	            }
      		}
    	}

		$this->data['token'] = $this->session->data['token'];

    	if (isset($this->request->post['name'])) {
      		$this->data['name'] = $this->request->post['name'];
    	} elseif (!empty($case_info)) {
			$this->data['name'] = $case_info['name'];
		} else {	
      		$this->data['name'] = '';
    	}
		
		if (isset($this->request->post['desc'])) {
      		$this->data['desc'] = $this->request->post['desc'];
    	} elseif (!empty($case_info)) {
			$this->data['desc'] = $case_info['desc'];
		} else {	
      		$this->data['desc'] = '';
    	}
		
		if (isset($this->request->post['keyword'])) {
			$this->data['keyword'] = $this->request->post['keyword'];
		} elseif (!empty($case_info)) {
			$this->data['keyword'] = $case_info['keyword'];
		} else {
			$this->data['keyword'] = '';
		}

		if (isset($this->request->post['cover'])) {
			$this->data['cover'] = $this->request->post['cover'];
		} elseif (!empty($case_info)) {
			$this->data['cover'] = $case_info['cover'];
		} else {
			$this->data['cover'] = '';
		}
		
		

		if (isset($this->request->post['cover']) && file_exists(DIR_IMAGE . $this->request->post['cover'])) {
			$this->data['thumb'] = $this->model_tool_image->resize($this->request->post['cover'], 100, 100);
		} elseif (!empty($case_info) && $case_info['cover'] && file_exists(DIR_IMAGE . $case_info['cover'])) {
			$this->data['thumb'] = $this->model_tool_image->resize($case_info['cover'], 100, 100);
		} else {
			$this->data['thumb'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		}
		
		$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		
		if (isset($this->request->post['sort_order'])) {
      		$this->data['sort_order'] = $this->request->post['sort_order'];
    	} elseif (!empty($case_info)) {
			$this->data['sort_order'] = $case_info['sort_order'];
		} else {
      		$this->data['sort_order'] = '';
    	}

    	$this->data['case_images'] = $file;
		
		$this->template = 'extension/case_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}  
	 
  	protected function validateForm() {
    	if (!$this->user->hasPermission('modify', 'extension/case')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}

    	if ((utf8_strlen($this->request->post['name']) < 2) || (utf8_strlen($this->request->post['name']) > 64)) {
      		$this->error['name'] = $this->language->get('error_name');
    	}
		
		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}
  	}    

  	protected function validateDelete() {
    	if (!$this->user->hasPermission('modify', 'extension/case')) {
			$this->error['warning'] = $this->language->get('error_permission');
    	}	
		
	
		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}  
  	}
	
	public function autocomplete() {
		$json = array();
		
		if (isset($this->request->get['filter_name'])) {
			$this->load->model('extension/case');
			
			$data = array(
				'filter_name' => $this->request->get['filter_name'],
				'start'       => 0,
				'limit'       => 20
			);
			
			$results = $this->model_extension_case->getCases($data);
				
			foreach ($results as $result) {
				$json[] = array(
					'case_id' => $result['case_id'], 
					'name'            => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
				);
			}		
		}

		$sort_order = array();
	  
		foreach ($json as $key => $value) {
			$sort_order[$key] = $value['name'];
		}

		array_multisort($sort_order, SORT_ASC, $json);

		$this->response->setOutput(json_encode($json));
	}	
}