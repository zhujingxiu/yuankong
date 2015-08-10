<?php    
class ControllerSaleCompany extends Controller { 
	private $error = array();
  
  	public function index() {
		$this->language->load('sale/company');
		 
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('sale/company');
		
    	$this->getList();
  	}
  
  	public function insert() {
		$this->language->load('sale/company');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('sale/company');
			
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
      	  	$this->model_sale_company->addCompany($this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');
		  
			$url = '';

			if (isset($this->request->get['filter_title'])) {
				$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
			}
			
			if (isset($this->request->get['filter_corporation'])) {
				$url .= '&filter_corporation=' . urlencode(html_entity_decode($this->request->get['filter_corporation'], ENT_QUOTES, 'UTF-8'));
			}
			if (isset($this->request->get['filter_mobile_phone'])) {
				$url .= '&filter_mobile_phone=' . urlencode(html_entity_decode($this->request->get['filter_mobile_phone'], ENT_QUOTES, 'UTF-8'));
			}
			
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}
			if (isset($this->request->get['filter_group_id'])) {
				$url .= '&filter_group_id=' . $this->request->get['filter_group_id'];
			}
			if (isset($this->request->get['filter_approved'])) {
				$url .= '&filter_approved=' . $this->request->get['filter_approved'];
			}
			if (isset($this->request->get['filter_zone_id'])) {
				$url .= '&filter_zone_id=' . $this->request->get['filter_zone_id'];
			}
			if (isset($this->request->get['filter_date_added'])) {
				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
			}
							
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->redirect($this->url->link('sale/company', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    	
    	$this->getForm();
  	} 
   
  	public function update() {
		$this->language->load('sale/company');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('sale/company');
		
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_sale_company->editCompany($this->request->get['company_id'], $this->request->post);
	  		
			$this->session->data['success'] = $this->language->get('text_success');
	  
			$url = '';

			if (isset($this->request->get['filter_title'])) {
				$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
			}
			if (isset($this->request->get['filter_corporation'])) {
				$url .= '&filter_corporation=' . urlencode(html_entity_decode($this->request->get['filter_corporation'], ENT_QUOTES, 'UTF-8'));
			}
			if (isset($this->request->get['filter_mobile_phone'])) {
				$url .= '&filter_mobile_phone=' . urlencode(html_entity_decode($this->request->get['filter_mobile_phone'], ENT_QUOTES, 'UTF-8'));
			}
					
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}
			if (isset($this->request->get['filter_group_id'])) {
				$url .= '&filter_group_id=' . $this->request->get['filter_group_id'];
			}
			if (isset($this->request->get['filter_approved'])) {
				$url .= '&filter_approved=' . $this->request->get['filter_approved'];
			}
			if (isset($this->request->get['filter_zone_id'])) {
				$url .= '&filter_zone_id=' . $this->request->get['filter_zone_id'];
			}
		
			if (isset($this->request->get['filter_date_added'])) {
				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
			}
						
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->redirect($this->url->link('sale/company', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
    
    	$this->getForm();
  	}   

  	public function delete() {
		$this->language->load('sale/company');

    	$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('sale/company');
			
    	if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $company_id) {
				$this->model_sale_company->deleteCompany($company_id);
			}
			
			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_title'])) {
				$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
			}
			if (isset($this->request->get['filter_corporation'])) {
				$url .= '&filter_corporation=' . urlencode(html_entity_decode($this->request->get['filter_corporation'], ENT_QUOTES, 'UTF-8'));
			}
			if (isset($this->request->get['filter_mobile_phone'])) {
				$url .= '&filter_mobile_phone=' . urlencode(html_entity_decode($this->request->get['filter_mobile_phone'], ENT_QUOTES, 'UTF-8'));
			}
								
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}
			if (isset($this->request->get['filter_group_id'])) {
				$url .= '&filter_group_id=' . $this->request->get['filter_group_id'];
			}
			if (isset($this->request->get['filter_approved'])) {
				$url .= '&filter_approved=' . $this->request->get['filter_approved'];
			}
			if (isset($this->request->get['filter_zone_id'])) {
				$url .= '&filter_zone_id=' . $this->request->get['filter_zone_id'];
			}		
		
			if (isset($this->request->get['filter_date_added'])) {
				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
			}
						
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->redirect($this->url->link('sale/company', 'token=' . $this->session->data['token'] . $url, 'SSL'));
    	}
    
    	$this->getList();
  	}  
		 
	public function approve() {
		$this->language->load('sale/company');
    	
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('sale/company');	
		
		if (!$this->user->hasPermission('modify', 'sale/company')) {
			$this->error['warning'] = $this->language->get('error_permission');
		} elseif (isset($this->request->post['selected'])) {
			$approved = 0;
			
			foreach ($this->request->post['selected'] as $company_id) {
				$company_info = $this->model_sale_company->getCompany($company_id);
				
				if ($company_info && !$company_info['approved']) {
					$this->model_sale_company->approve($company_id);
				
					$approved++;
				}
			}
			
			$this->session->data['success'] = sprintf($this->language->get('text_approved'), $approved);
			
			$url = '';
		
			if (isset($this->request->get['filter_title'])) {
				$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
			}
			if (isset($this->request->get['filter_corporation'])) {
				$url .= '&filter_corporation=' . urlencode(html_entity_decode($this->request->get['filter_corporation'], ENT_QUOTES, 'UTF-8'));
			}
			if (isset($this->request->get['filter_mobile_phone'])) {
				$url .= '&filter_mobile_phone=' . urlencode(html_entity_decode($this->request->get['filter_mobile_phone'], ENT_QUOTES, 'UTF-8'));
			}
		
			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}
			if (isset($this->request->get['filter_group_id'])) {
				$url .= '&filter_group_id=' . $this->request->get['filter_group_id'];
			}
			if (isset($this->request->get['filter_approved'])) {
				$url .= '&filter_approved=' . $this->request->get['filter_approved'];
			}
			if (isset($this->request->get['filter_zone_id'])) {
				$url .= '&filter_zone_id=' . $this->request->get['filter_zone_id'];
			}	
			
			if (isset($this->request->get['filter_date_added'])) {
				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
			}
						
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}
		
			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
							
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}	
		
			$this->redirect($this->url->link('sale/company', 'token=' . $this->session->data['token'] . $url, 'SSL'));					
		}
		
		$this->getList();
	} 
	    
  	protected function getList() {
		if (isset($this->request->get['filter_title'])) {
			$filter_title = $this->request->get['filter_title'];
		} else {
			$filter_title = null;
		}

		if (isset($this->request->get['filter_corporation'])) {
			$filter_corporation = $this->request->get['filter_corporation'];
		} else {
			$filter_corporation = null;
		}

		if (isset($this->request->get['filter_group_id'])) {
			$filter_group_id = $this->request->get['filter_group_id'];
		} else {
			$filter_group_id = null;
		}

		if (isset($this->request->get['filter_zone_id'])) {
			$filter_zone_id = $this->request->get['filter_zone_id'];
		} else {
			$filter_zone_id = null;
		}

		if (isset($this->request->get['filter_mobile_phone'])) {
			$filter_mobile_phone = $this->request->get['filter_mobile_phone'];
		} else {
			$filter_mobile_phone = null;
		}
		
		if (isset($this->request->get['filter_status'])) {
			$filter_status = $this->request->get['filter_status'];
		} else {
			$filter_status = null;
		}
		
		if (isset($this->request->get['filter_approved'])) {
			$filter_approved = $this->request->get['filter_approved'];
		} else {
			$filter_approved = null;
		}
		
		if (isset($this->request->get['filter_date_added'])) {
			$filter_date_added = $this->request->get['filter_date_added'];
		} else {
			$filter_date_added = null;
		}	
			
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'c.date_added'; 
		}
		
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'DESC';
		}
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
						
		$url = '';

		if (isset($this->request->get['filter_title'])) {
			$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
		}
		if (isset($this->request->get['filter_corporation'])) {
			$url .= '&filter_corporation=' . urlencode(html_entity_decode($this->request->get['filter_corporation'], ENT_QUOTES, 'UTF-8'));
		}
		if (isset($this->request->get['filter_mobile_phone'])) {
			$url .= '&filter_mobile_phone=' . urlencode(html_entity_decode($this->request->get['filter_mobile_phone'], ENT_QUOTES, 'UTF-8'));
		}
						
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['filter_group_id'])) {
			$url .= '&filter_group_id=' . $this->request->get['filter_group_id'];
		}
		if (isset($this->request->get['filter_group_id'])) {
			$url .= '&filter_group_id=' . $this->request->get['filter_group_id'];
		}
		if (isset($this->request->get['filter_approved'])) {
			$url .= '&filter_approved=' . $this->request->get['filter_approved'];
		}
		if (isset($this->request->get['filter_zone_id'])) {
			$url .= '&filter_zone_id=' . $this->request->get['filter_zone_id'];
		}	
			
		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}
						
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
			'href'      => $this->url->link('sale/company', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['approve'] = $this->url->link('sale/company/approve', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['insert'] = $this->url->link('sale/company/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('sale/company/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->data['companies'] = array();

		$data = array(
			'filter_title'       => $filter_title, 
			'filter_mobile_phone'=> $filter_mobile_phone, 
			'filter_corporation' => $filter_corporation, 
			'filter_status'     => $filter_status, 
			'filter_group_id'   => $filter_group_id, 
			'filter_zone_id'    => $filter_zone_id, 
			'filter_approved'   => $filter_approved, 
			'filter_date_added' => $filter_date_added,
			'sort'              => $sort,
			'order'             => $order,
			'start'             => ($page - 1) * $this->config->get('config_admin_limit'),
			'limit'             => $this->config->get('config_admin_limit')
		);
		
		$company_total = $this->model_sale_company->getTotalCompanies($data);
	
		$results = $this->model_sale_company->getCompanies($data);
 
    	foreach ($results as $result) {
			$action = array();
		
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('sale/company/update', 'token=' . $this->session->data['token'] . '&company_id=' . $result['company_id'] . $url, 'SSL')
			);
			$group_name = array();
			$groups = $this->model_sale_company->getCompanyGroups($result['company_id']);
			if($groups){
				foreach ($groups as $item) {
					$group_name[] = $item['name'];
				}
			}
			$this->data['companies'][] = array(
				'company_id'   => $result['company_id'],
				'title'        => $result['title'],
				'corporation'  => $result['corporation'],
				'group'        => implode("<br>", $group_name),
				'zone'         => $result['zone'],
				'mobile_phone' => $result['mobile_phone'],
				'status'       => ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
				'approved'     => ($result['approved'] ? $this->language->get('text_yes') : $this->language->get('text_no')),
				'date_added'   => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'selected'     => isset($this->request->post['selected']) && in_array($result['company_id'], $this->request->post['selected']),
				'action'       => $action
			);
		}	
					
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');		
		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_title'] = $this->language->get('column_title');
		$this->data['column_group'] = $this->language->get('column_group');
		$this->data['column_zone'] = $this->language->get('column_zone');
		$this->data['column_mobile_phone'] = $this->language->get('column_mobile_phone');
		$this->data['column_corporation'] = $this->language->get('column_corporation');
		$this->data['column_status'] = $this->language->get('column_status');
		$this->data['column_approved'] = $this->language->get('column_approved');
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_action'] = $this->language->get('column_action');		
		
		$this->data['button_approve'] = $this->language->get('button_approve');
		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_delete'] = $this->language->get('button_delete');
		$this->data['button_filter'] = $this->language->get('button_filter');

		$this->data['token'] = $this->session->data['token'];

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

		if (isset($this->request->get['filter_title'])) {
			$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
		}
		if (isset($this->request->get['filter_corporation'])) {
			$url .= '&filter_corporation=' . urlencode(html_entity_decode($this->request->get['filter_corporation'], ENT_QUOTES, 'UTF-8'));
		}
		if (isset($this->request->get['filter_mobile_phone'])) {
			$url .= '&filter_mobile_phone=' . urlencode(html_entity_decode($this->request->get['filter_mobile_phone'], ENT_QUOTES, 'UTF-8'));
		}
			
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		if (isset($this->request->get['filter_group_id'])) {
			$url .= '&filter_group_id=' . $this->request->get['filter_group_id'];
		}
		if (isset($this->request->get['filter_approved'])) {
			$url .= '&filter_approved=' . $this->request->get['filter_approved'];
		}
		if (isset($this->request->get['filter_zone_id'])) {
			$url .= '&filter_zone_id=' . $this->request->get['filter_zone_id'];
		}	
		
		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}
			
		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$this->data['sort_title'] = $this->url->link('sale/company', 'token=' . $this->session->data['token'] . '&sort=c.title' . $url, 'SSL');
		$this->data['sort_group'] = $this->url->link('sale/company', 'token=' . $this->session->data['token'] . '&sort=c.group_id' . $url, 'SSL');
		$this->data['sort_zone'] = $this->url->link('sale/company', 'token=' . $this->session->data['token'] . '&sort=c.zone_id' . $url, 'SSL');
		$this->data['sort_mobile_phone'] = $this->url->link('sale/company', 'token=' . $this->session->data['token'] . '&sort=c.mobile_phone' . $url, 'SSL');
		$this->data['sort_status'] = $this->url->link('sale/company', 'token=' . $this->session->data['token'] . '&sort=c.status' . $url, 'SSL');
		$this->data['sort_approved'] = $this->url->link('sale/company', 'token=' . $this->session->data['token'] . '&sort=c.approved' . $url, 'SSL');
		$this->data['sort_date_added'] = $this->url->link('sale/company', 'token=' . $this->session->data['token'] . '&sort=c.date_added' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['filter_title'])) {
			$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
		}
		if (isset($this->request->get['filter_corporation'])) {
				$url .= '&filter_corporation=' . urlencode(html_entity_decode($this->request->get['filter_corporation'], ENT_QUOTES, 'UTF-8'));
			}
		if (isset($this->request->get['filter_mobile_phone'])) {
			$url .= '&filter_mobile_phone=' . urlencode(html_entity_decode($this->request->get['filter_mobile_phone'], ENT_QUOTES, 'UTF-8'));
		}
		
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		if (isset($this->request->get['filter_group_id'])) {
			$url .= '&filter_group_id=' . $this->request->get['filter_group_id'];
		}
		if (isset($this->request->get['filter_approved'])) {
			$url .= '&filter_approved=' . $this->request->get['filter_approved'];
		}
		if (isset($this->request->get['filter_zone_id'])) {
			$url .= '&filter_zone_id=' . $this->request->get['filter_zone_id'];
		}
		
		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}
			
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $company_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('sale/company', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();

		$this->data['filter_title'] = $filter_title;
		$this->data['filter_corporation'] = $filter_corporation;
		$this->data['filter_zone_id'] = $filter_zone_id;
		$this->data['filter_group_id'] = $filter_group_id;
		$this->data['filter_mobile_phone'] = $filter_mobile_phone;
		$this->data['filter_status'] = $filter_status;
		$this->data['filter_approved'] = $filter_approved;
		$this->data['filter_date_added'] = $filter_date_added;

		$this->load->model('extension/company_group');
		$this->data['groups'] = $this->model_extension_company_group->getCompanyGroups();
		
		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'sale/company_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
  	}
  
  	protected function getForm() {
    	$this->data['heading_title'] = $this->language->get('heading_title');
 		$this->document->addScript($this->area_js());
    	$this->data['text_enabled'] = $this->language->get('text_enabled');
    	$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_select'] = $this->language->get('text_select');
		$this->data['text_none'] = $this->language->get('text_none');
    	$this->data['text_wait'] = $this->language->get('text_wait');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_group'] = $this->language->get('text_group');
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
 		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['text_clear'] = $this->language->get('text_clear');	
				
    	$this->data['entry_corporation'] = $this->language->get('entry_corporation');
    	$this->data['entry_mobile_phone'] = $this->language->get('entry_mobile_phone');
    	$this->data['entry_email'] = $this->language->get('entry_email');
    	$this->data['entry_telephone'] = $this->language->get('entry_telephone');
    	$this->data['entry_fax'] = $this->language->get('entry_fax');
    	$this->data['entry_title'] = $this->language->get('entry_title');
    	$this->data['entry_logo'] = $this->language->get('entry_logo');
		$this->data['entry_address'] = $this->language->get('entry_address');
		$this->data['entry_area_zone'] = $this->language->get('entry_area_zone');
		$this->data['entry_zone'] = $this->language->get('entry_zone');
		$this->data['entry_postcode'] = $this->language->get('entry_postcode');
		$this->data['entry_commission'] = $this->language->get('entry_commission');
		$this->data['entry_code'] = $this->language->get('entry_code');
		$this->data['entry_password'] = $this->language->get('entry_password');
    	$this->data['entry_confirm'] = $this->language->get('entry_confirm');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_recommend'] = $this->language->get('entry_recommend');
 		$this->data['entry_deposit'] = $this->language->get('entry_deposit');
 		$this->data['entry_member'] = $this->language->get('entry_member');
 		$this->data['entry_position'] = $this->language->get('entry_position');
 		$this->data['entry_avatar'] = $this->language->get('entry_avatar');
 		$this->data['entry_note'] = $this->language->get('entry_note');
 		$this->data['entry_mode'] = $this->language->get('entry_mode');
 		$this->data['entry_sort'] = $this->language->get('entry_sort');
 		$this->data['entry_file'] = $this->language->get('entry_file');
 		$this->data['entry_identity'] = $this->language->get('entry_identity');
 		$this->data['entry_permit'] = $this->language->get('entry_permit');
 		$this->data['entry_description'] = $this->language->get('entry_description');
 		$this->data['entry_text'] = $this->language->get('entry_text');
 		$this->data['entry_image'] = $this->language->get('entry_image');
 
		$this->data['button_save'] = $this->language->get('button_save');
    	$this->data['button_add_member'] = $this->language->get('button_add_member');
    	$this->data['button_add_case'] = $this->language->get('button_add_case');
    	$this->data['button_add_file'] = $this->language->get('button_add_file');
    	$this->data['button_cancel'] = $this->language->get('button_cancel');
    	$this->data['button_remove'] = $this->language->get('button_remove');
	
		$this->data['tab_general'] = $this->language->get('tab_general');
		$this->data['tab_description'] = $this->language->get('tab_description');
		$this->data['tab_member'] = $this->language->get('tab_member');
		$this->data['tab_case'] = $this->language->get('tab_case');
		$this->data['tab_file'] = $this->language->get('tab_file');

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

 		if (isset($this->error['corporation'])) {
			$this->data['error_corporation'] = $this->error['corporation'];
		} else {
			$this->data['error_corporation'] = '';
		}

 		if (isset($this->error['mobile_phone'])) {
			$this->data['error_mobile_phone'] = $this->error['mobile_phone'];
		} else {
			$this->data['error_mobile_phone'] = '';
		}
		
 		if (isset($this->error['title'])) {
			$this->data['error_title'] = $this->error['title'];
		} else {
			$this->data['error_title'] = '';
		}

		
 		if (isset($this->error['password'])) {
			$this->data['error_password'] = $this->error['password'];
		} else {
			$this->data['error_password'] = '';
		}
		
 		if (isset($this->error['confirm'])) {
			$this->data['error_confirm'] = $this->error['confirm'];
		} else {
			$this->data['error_confirm'] = '';
		}
		
		if (isset($this->error['address'])) {
			$this->data['error_address'] = $this->error['address'];
		} else {
			$this->data['error_address'] = '';
		}
	
		if (isset($this->error['group'])) {
			$this->data['error_group'] = $this->error['group'];
		} else {
			$this->data['error_group'] = '';
		}				
		$url = '';
		
		if (isset($this->request->get['filter_title'])) {
			$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
		}
		
		if (isset($this->request->get['filter_mobile_phone'])) {
			$url .= '&filter_mobile_phone=' . urlencode(html_entity_decode($this->request->get['filter_mobile_phone'], ENT_QUOTES, 'UTF-8'));
		}
		
		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}
		
		if (isset($this->request->get['filter_approved'])) {
			$url .= '&filter_approved=' . $this->request->get['filter_approved'];
		}	
		
		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}
						
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
			'href'      => $this->url->link('sale/company', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);

		if (!isset($this->request->get['company_id'])) {
			$this->data['action'] = $this->url->link('sale/company/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('sale/company/update', 'token=' . $this->session->data['token'] . '&company_id=' . $this->request->get['company_id'] . $url, 'SSL');
		}
		  
    	$this->data['cancel'] = $this->url->link('sale/company', 'token=' . $this->session->data['token'] . $url, 'SSL');

    	if (isset($this->request->get['company_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
      		$company_info = $this->model_sale_company->getCompany($this->request->get['company_id']);
      		$company_description = $this->model_sale_company->getCompanyDescription($this->request->get['company_id']);
    	}

		$this->data['token'] = $this->session->data['token'];

		if (isset($this->request->get['company_id'])) {
			$this->data['company_id'] = $this->request->get['company_id'];
		} else {
			$this->data['company_id'] = 0;
		}

		if (isset($this->request->post['title'])) {
      		$this->data['title'] = $this->request->post['title'];
		} elseif (!empty($company_info['title'])) { 
			$this->data['title'] = $company_info['title'];
		} else {
      		$this->data['title'] = '';
    	}
    	$this->load->model('tool/image');
    	if (isset($this->request->post['logo'])) {
      		$this->data['logo'] = $this->request->post['logo'];
		} elseif (!empty($company_info['logo'])) { 
			$this->data['logo'] = $this->model_tool_image->resize($company_info['logo'], 100, 100);
		} else {
      		$this->data['logo'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
    	}
					
    	if (isset($this->request->post['corporation'])) {
      		$this->data['corporation'] = $this->request->post['corporation'];
		} elseif (!empty($company_info['corporation'])) { 
			$this->data['corporation'] = $company_info['corporation'];
		} else {
      		$this->data['corporation'] = '';
    	}

    	if (isset($this->request->post['mobile_phone'])) {
      		$this->data['mobile_phone'] = $this->request->post['mobile_phone'];
    	} elseif (!empty($company_info['mobile_phone'])) { 
			$this->data['mobile_phone'] = $company_info['mobile_phone'];
		} else {
      		$this->data['mobile_phone'] = '';
    	}

    	if (isset($this->request->post['group_id'])) {
      		$this->data['group_id'] = $this->request->post['group_id'];
    	} elseif (!empty($this->request->get['company_id'])) { 
			$this->data['group_id'] = $this->model_sale_company->getCompanyGroups($this->request->get['company_id'],true);
		} else {
      		$this->data['group_id'] = array();
    	}

    	if (isset($this->request->post['email'])) {
      		$this->data['email'] = $this->request->post['email'];
    	} elseif (!empty($company_info)) { 
			$this->data['email'] = $company_info['email'];
		} else {
      		$this->data['email'] = '';
    	}

    	if (isset($this->request->post['telephone'])) {
      		$this->data['telephone'] = $this->request->post['telephone'];
    	} elseif (!empty($company_info)) { 
			$this->data['telephone'] = $company_info['telephone'];
		} else {
      		$this->data['telephone'] = '';
    	}

    	if (isset($this->request->post['fax'])) {
      		$this->data['fax'] = $this->request->post['fax'];
    	} elseif (!empty($company_info)) { 
			$this->data['fax'] = $company_info['fax'];
		} else {
      		$this->data['fax'] = '';
    	}
		if (isset($this->request->post['area_zone'])) {
      		$this->data['area_zone'] = $this->request->post['area_zone'];
    	} elseif (!empty($company_info['area_zone'])) { 
			$this->data['area_zone'] = $company_info['area_zone'];
		} else {
      		$this->data['area_zone'] = '';
    	}
    	if (isset($this->request->post['address'])) {
      		$this->data['address'] = $this->request->post['address'];
    	} elseif (!empty($company_info['address'])) { 
			$this->data['address'] = $company_info['address'];
		} else {
      		$this->data['address'] = '';
    	}

    	if (isset($this->request->post['zone_id'])) {
      		$this->data['zone_id'] = $this->request->post['zone_id'];
    	} elseif (!empty($this->request->get['company_id'])) { 
			$this->data['zone_id'] = $company_info['zone_id'];
		} else {
      		$this->data['zone_id'] = '';
    	}

    	if (isset($this->request->post['postcode'])) {
      		$this->data['postcode'] = $this->request->post['postcode'];
    	} elseif (!empty($company_info['postcode'])) { 
			$this->data['postcode'] = $company_info['postcode'];
		} else {
      		$this->data['postcode'] = '';
    	}

		if (isset($this->request->post['code'])) {
      		$this->data['code'] = $this->request->post['code'];
    	} elseif (!empty($company_info['code'])) { 
			$this->data['code'] = $company_info['code'];
		} else {
      		$this->data['code'] = uniqid();
    	}
																												
    	if (isset($this->request->post['status'])) {
      		$this->data['status'] = $this->request->post['status'];
    	} elseif (!empty($company_info['status'])) { 
			$this->data['status'] = $company_info['status'];
		} else {
      		$this->data['status'] = 1;
    	}

    	if (isset($this->request->post['recommend'])) {
      		$this->data['recommend'] = $this->request->post['recommend'];
    	} elseif (!empty($company_info['recommend'])) { 
			$this->data['recommend'] = $company_info['recommend'];
		} else {
      		$this->data['recommend'] = 0;
    	}

    	if (isset($this->request->post['deposit'])) {
      		$this->data['deposit'] = $this->request->post['deposit'];
    	} elseif (!empty($company_info['deposit'])) { 
			$this->data['deposit'] = $company_info['deposit'];
		} else {
      		$this->data['deposit'] = 0;
    	}

    	if (isset($this->request->post['password'])) { 
			$this->data['password'] = $this->request->post['password'];
		} else {
			$this->data['password'] = '';
		}
		
		if (isset($this->request->post['confirm'])) { 
    		$this->data['confirm'] = $this->request->post['confirm'];
		} else {
			$this->data['confirm'] = '';
		}

		if (isset($this->request->post['dtitle'])) {
      		$this->data['dtitle'] = $this->request->post['dtitle'];
    	} elseif (!empty($company_description['title'])) { 
			$this->data['dtitle'] = $company_description['title'];
		} else {
      		$this->data['dtitle'] = '';
    	}

    	if (isset($this->request->post['text'])) {
      		$this->data['text'] = $this->request->post['text'];
    	} elseif (!empty($company_description['text'])) { 
			$this->data['text'] = $company_description['text'];
		} else {
      		$this->data['text'] = '';
    	}

    	if (isset($this->request->post['image'])) {
      		$this->data['image'] = $this->request->post['image'];
    	} elseif (!empty($company_description['image'])) { 
			$this->data['image'] = $company_description['image'];
		} else {
      		$this->data['image'] = '';
    	}
        $this->load->model('extension/company_group');
        $this->data['groups'] = $this->model_extension_company_group->getCompanyGroups();
		$this->load->model('extension/company_zone');
        $this->data['zones'] = $this->model_extension_company_zone->getCompanyZones();
     	$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
		$this->template = 'sale/company_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}

	public function file() {
    	$this->language->load('sale/company');
		
		$this->load->model('sale/company');
		$this->load->model('tool/image');
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->user->hasPermission('modify', 'sale/company')) { 
			$this->model_sale_company->addFile($this->request->get['company_id'], $this->request->post);
				
			$this->data['success'] = $this->language->get('text_success');
		} else {
			$this->data['success'] = '';
		}
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && !$this->user->hasPermission('modify', 'sale/company')) {
			$this->data['error_warning'] = $this->language->get('error_permission');
		} else {
			$this->data['error_warning'] = '';
		}		
		
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['token'] = $this->session->data['token'];
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_file'] = $this->language->get('column_file');
		$this->data['column_mode'] = $this->language->get('column_mode');
		$this->data['column_note'] = $this->language->get('column_note');
		$this->data['column_sort'] = $this->language->get('column_sort');
		$this->data['column_status'] = $this->language->get('column_status');
		$this->data['column_action'] = $this->language->get('column_action');
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}  
		
		$this->data['files'] = array();
			
		$results = $this->model_sale_company->getFiles($this->request->get['company_id'], ($page - 1) * 10, 10);
      		
		foreach ($results as $result) {
			$action = array();
		
			$action[] = array(
				'text' 		=> $this->language->get('text_edit'),
				'onclick' 	=> 'file_detail(' . $result['file_id'].')'
			);
			$action[] = array(
				'text' 		=> $this->language->get('text_delete'),
				'onclick' 	=> 'file_delete(' . $result['file_id'].')'
			);
        	$this->data['files'][] = array(
				'file'      => $this->model_tool_image->resize($result['path'], 100,100),
				'note' 		=> $result['note'],
				'sort' 		=> $result['sort'],
				'mode' 		=> strtolower($result['mode'])=='identity' ? $this->language->get('entry_identity') : $this->language->get('entry_permit'),
				'status' 	=> $result['status'] ? $this->language->get('text_approved') : $this->language->get('text_unapprove'),
        		'date_added'=> date($this->language->get('date_format_short'), strtotime($result['date_added'])),
        		'action'	=> $action
        	);
      	}			

		$file_total = $this->model_sale_company->getTotalFiles($this->request->get['company_id']);
			
		$pagination = new Pagination();
		$pagination->total = $file_total;
		$pagination->page = $page;
		$pagination->limit = 10; 
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('sale/company/file', 'token=' . $this->session->data['token'] . '&company_id=' . $this->request->get['company_id'] . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();

		$this->template = 'sale/company_file.tpl';		
		
		$this->response->setOutput($this->render());
	}
			
	public function member() {
    	$this->language->load('sale/company');
		
		$this->load->model('sale/company');
		$this->load->model('tool/image');
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->user->hasPermission('modify', 'sale/company')) { 
			$this->model_sale_company->addMember($this->request->get['company_id'], $this->request->post);
				
			$this->data['success'] = $this->language->get('text_success');
		} else {
			$this->data['success'] = '';
		}
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && !$this->user->hasPermission('modify', 'sale/company')) {
			$this->data['error_warning'] = $this->language->get('error_permission');
		} else {
			$this->data['error_warning'] = '';
		}	
		$this->data['token'] = $this->session->data['token'];		
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_member'] = $this->language->get('column_member');
		$this->data['column_position'] = $this->language->get('column_position');
		$this->data['column_avatar'] = $this->language->get('column_avatar');
		$this->data['column_note'] = $this->language->get('column_note');
		$this->data['column_sort'] = $this->language->get('column_sort');
		$this->data['column_action'] = $this->language->get('column_action');

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}  
		
		$this->data['members'] = array();
			
		$results = $this->model_sale_company->getMembers($this->request->get['company_id'], ($page - 1) * 10, 10);
      		
		foreach ($results as $result) {
        	$this->data['members'][] = array(
        		'name' 		=> $result['name'],
        		'position' 	=> $result['position'],
				'avatar'    => $this->model_tool_image->resize($result['avatar'], 100,100),
				'note' 		=> $result['note'],
				'sort' 		=> $result['sort'],
        		'date_added'=> date($this->language->get('date_format_short'), strtotime($result['date_added']))
        	);
      	}			
		
		
		$member_total = $this->model_sale_company->getTotalMembers($this->request->get['company_id']);
			
		$pagination = new Pagination();
		$pagination->total = $member_total;
		$pagination->page = $page;
		$pagination->limit = 10; 
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('sale/company/member', 'token=' . $this->session->data['token'] . '&company_id=' . $this->request->get['company_id'] . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();

		$this->template = 'sale/company_member.tpl';		
		
		$this->response->setOutput($this->render());
	}

	public function ajax_data(){
		$this->load->model('sale/company');
		$this->load->language('sale/company');
		if(isset($this->request->get['action'])){
			$action = strtolower(trim($this->request->get['action']));
		}else if(isset($this->request->post['action'])){
			$action = strtolower(trim($this->request->post['action']));
		}else{
			$action = 'get';
		}
		$json = array();
		switch ($action) {
			case 'get_file':
				$file_id = isset($this->request->get['file_id']) ? (int)$this->request->get['file_id'] : false;
				$file = $this->model_sale_company->getCompanyFile($file_id);
				$json['status'] = 1;
				$json['data']	= $file;
			break;
		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
  	protected function validateForm() {
    	if (!$this->user->hasPermission('modify', 'sale/company')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}
		if ((utf8_strlen($this->request->post['title']) < 1) || (utf8_strlen($this->request->post['title']) > 32)) {
      		$this->error['title'] = $this->language->get('error_title');
    	}
    	if ((utf8_strlen($this->request->post['corporation']) < 1) || (utf8_strlen($this->request->post['corporation']) > 32)) {
      		$this->error['corporation'] = $this->language->get('error_corporation');
    	}

    	if ((utf8_strlen($this->request->post['mobile_phone']) < 1) || !isMobile($this->request->post['mobile_phone'])) {
      		$this->error['mobile_phone'] = $this->language->get('error_mobile_phone');
    	}
		
		$company_info = $this->model_sale_company->getCompanyByMobilePhone($this->request->post['mobile_phone']);
		
		if (!isset($this->request->get['company_id'])) {
			if ($company_info) {
				$this->error['warning'] = $this->language->get('error_exists');
			}
		} else {
			if ($company_info && ($this->request->get['company_id'] != $company_info['company_id'])) {
				$this->error['warning'] = $this->language->get('error_exists');
			}
		}

    	if ($this->request->post['password'] || (!isset($this->request->get['company_id']))) {
      		if ((utf8_strlen($this->request->post['password']) < 4) || (utf8_strlen($this->request->post['password']) > 20)) {
        		$this->error['password'] = $this->language->get('error_password');
      		}
	
	  		if ($this->request->post['password'] != $this->request->post['confirm']) {
	    		$this->error['confirm'] = $this->language->get('error_confirm');
	  		}
    	}
		
    	if ((utf8_strlen($this->request->post['address']) < 3) || (utf8_strlen($this->request->post['address']) > 128)) {
      		$this->error['address'] = $this->language->get('error_address');
    	}

    	if (!isset($this->request->post['group_id']) || !$this->request->post['group_id']) {
      		$this->error['group'] = $this->language->get('error_group');
    	}

		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}
  	}    

  	protected function validateDelete() {
    	if (!$this->user->hasPermission('modify', 'sale/company')) {
      		$this->error['warning'] = $this->language->get('error_permission');
    	}	
	  	 
		if (!$this->error) {
	  		return true;
		} else {
	  		return false;
		}  
  	} 
		
	public function autocomplete() {
		$company_data = array();
		
		if (isset($this->request->get['filter_title'])) {
			$this->load->model('sale/company');
			
			$data = array(
				'filter_title' => $this->request->get['filter_title'],
				'start'       => 0,
				'limit'       => 20
			);
		
			$results = $this->model_sale_company->getCompanys($data);
			
			foreach ($results as $result) {
				$company_data[] = array(
					'company_id' => $result['company_id'],
					'name'         => html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')
				);
			}
		}
		
		$this->response->setOutput(json_encode($company_data));
	}	

	private function area_js(){
        $file = '..'.TPL_JS.'area.js';
        if(!file_exists($file)){
            $this->load->model('localisation/area');
            $areas = $this->model_localisation_area->getAreas();
            $area_rows_group_by_pid = $this->array_group($areas, 'pid');
            $address = array();
            foreach ($area_rows_group_by_pid as $pid => $item) {
                if ($pid == 0) {                    
                    $item = array_filter($item, function($item){
                        return $item['pid'] == 0;
                    });
                }
                $address['name'.$pid] = array_keys($this->array_group($item, 'name'));
                $address['code'.$pid] = array_keys($this->array_group($item, 'area_id'));
            }
            file_put_contents($file, 'var area = ' . json_encode_ex($address) . ';');            
        }
        return $file;
    }  

    private function array_group($array, $key, $limit = false){
        if (empty ($array) || !is_array($array)){
            return $array;
        }

        $_result = array ();
        foreach ($array as $item) {
            if ((isset($item[$key]))) {
                $_result[(string)$item[$key]][] = $item;
            } else {
                $_result[count($_result)][] = $item;
            }
        }
        if (!$limit) {
            return $_result;
        }

        $result = array ();
        foreach ($_result as $k => $item) {
            $result[$k] = $item[0];
        }
        return $result;
    } 	
}
