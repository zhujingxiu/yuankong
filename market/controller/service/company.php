<?php 
class ControllerServiceCompany extends Controller {
	private $error = array();
		
	public function index() {
		$this->language->load('service/company');
		$this->load->model('service/company');

		$this->load->model('tool/image'); 
		if (isset($this->request->get['search'])) {
			$filter_search = $this->request->get['search'];
		} else {
			$filter_search = null;
		}

		if (isset($this->request->get['company'])) {
			$filter_company = $this->request->get['company'];
		} else {
			$filter_company = null;
		}

		if (isset($this->request->get['zone'])) {
			$filter_zone = $this->request->get['zone'];
		} else {
			$filter_zone = null;
		}

		if (isset($this->request->get['group'])) {
			$filter_group = $this->request->get['group'];
		} else {
			$filter_group = null;
		}
				
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'c.sort_order';
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
							
		if (isset($this->request->get['limit'])) {
			$limit = $this->request->get['limit'];
		} else {
			$limit = 10;
		}

        $this->document->setTitle($this->language->get('heading_title'));
		$this->document->addStyle('market/view/theme/yuankong/stylesheet/yk_zt.css');
		$this->document->addScript('market/view/theme/yuankong/javascript/validation.js');
      	$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),        	
        	'separator' => false
      	); 

      	$this->data['text_sort_viewed'] = $this->language->get('text_sort_viewed');
		$this->data['text_sort_recommend'] = $this->language->get('text_sort_recommend');
		$this->data['text_sort_credit'] = $this->language->get('text_sort_credit');
		$this->data['text_sort_default'] = $this->language->get('text_sort_default');
		
		$url = '';
		if (isset($this->request->get['search'])) {
			$url .= '&search=' . $this->request->get['search'];
		}
		if (isset($this->request->get['company'])) {
			$url .= '&company=' . $this->request->get['company'];
		}
		if (isset($this->request->get['zone'])) {
			$url .= '&zone=' . $this->request->get['zone'];
		}
		if (isset($this->request->get['group'])) {
			$url .= '&group=' . $this->request->get['group'];
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
				
      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('service/company', $url, 'SSL'),        	
        	'separator' => $this->language->get('text_separator')
      	);
		$url = '';
		if (isset($this->request->get['search'])) {
			$url .= '&search=' . $this->request->get['search'];
		}
		if (isset($this->request->get['group'])) {
			$url .= '&group=' . $this->request->get['group'];
		}
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
		
      	$this->data['zones'] = $this->model_service_company->getCompanyZones();
      	foreach ($this->data['zones'] as $key => $item) {
      		$this->data['zones'][$key]['link'] = $this->url->link('service/company', 'zone='.$item['zone_id'].$url, 'SSL');  
      	}
      	$url = '';
		if (isset($this->request->get['search'])) {
			$url .= '&search=' . $this->request->get['search'];
		}
		if (isset($this->request->get['zone'])) {
			$url .= '&zone=' . $this->request->get['zone'];
		}
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
		$this->data['groups'] = $this->model_service_company->getCompanyGroups();
		foreach ($this->data['groups'] as $key => $item) {
      		$this->data['groups'][$key]['link'] = $this->url->link('service/company', 'group='.$item['group_id'].$url, 'SSL');  
      	}
		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['entry_type'] = $this->language->get('entry_type');

		$filter_data = array(
			'filter_search'=> $filter_search,
			'filter_company'=> $filter_company,
			'filter_zone' 	=> $filter_zone,
			'filter_group'  => $filter_group, 
			'sort'          => $sort,
			'order'         => $order,
			'start'         => ($page - 1) * $limit,
			'limit'         => $limit
		);
		$this->data['companies'] = array();
		$totals = $this->model_service_company->getTotalCompanies($filter_data); 
		
		$results = $this->model_service_company->getCompanies($filter_data);

		foreach ($results as $result) {
			if ($result['logo']) {
				$result['logo'] = $this->model_tool_image->resize_upload($result['logo'], 117, 117);
			} else {
				$result['logo'] = $this->model_tool_image->resize("nopic.jpg", 117, 117);
			}
			$result['groups'] = $this->model_service_company->getCompanyGroupsByCompanyId($result['company_id']);
			$result['link'] = $this->url->link("service/company/info", 'company_id='.$result['company_id'], 'SSL');
			$this->data['companies'][] = $result;
		}

		$url = '';
		if (isset($this->request->get['search'])) {
			$url .= '&search=' . $this->request->get['search'];
		}
		if (isset($this->request->get['zone'])) {
			$url .= '&zone=' . $this->request->get['zone'];
		}
		if (isset($this->request->get['group'])) {
			$url .= '&group=' . $this->request->get['group'];
		}
		if(isset($this->request->get['order']) && strtolower($this->request->get['order']) == 'desc'){
			$this->data['sort_order'] = $this->url->link('service/company',  '&sort=c.sort_order&order=ASC' . $url);
			$this->data['sort_viewed'] = $this->url->link('service/company',  '&sort=c.viewed&order=ASC' . $url);
			$this->data['sort_credit'] = $this->url->link('service/company',  '&sort=c.credit&order=ASC' . $url);
			$this->data['sort_recommend'] = $this->url->link('service/company',  '&sort=c.recommend&order=ASC' . $url);
		}else{
			$this->data['sort_order'] = $this->url->link('service/company',  '&sort=c.sort_order&order=DESC' . $url);
			$this->data['sort_viewed'] = $this->url->link('service/company',  '&sort=c.viewed&order=DESC' . $url);
			$this->data['sort_credit'] = $this->url->link('service/company',  '&sort=c.credit&order=DESC' . $url);
			$this->data['sort_recommend'] = $this->url->link('service/company',  '&sort=c.recommend&order=DESC' . $url);
		}
		if(isset($this->request->get['sort'])&& strtolower($this->request->get['sort']) == 'c.recommend'){
			$this->data['sort_on'] = 'recommend';
		}else if(isset($this->request->get['sort'])&& strtolower($this->request->get['sort']) == 'c.viewed'){
			$this->data['sort_on'] = 'viewed';
		}else if(isset($this->request->get['sort'])&& strtolower($this->request->get['sort']) == 'c.credit'){
			$this->data['sort_on'] = 'credit';
		}else{
			$this->data['sort_on'] = 'sort_order';
		}

		$url = '';
		if (isset($this->request->get['search'])) {
			$url .= '&search=' . $this->request->get['search'];
		}
		if (isset($this->request->get['company'])) {
			$url .= '&company=' . $this->request->get['company'];
		}
		if (isset($this->request->get['zone'])) {
			$url .= '&zone=' . $this->request->get['zone'];
		}
		if (isset($this->request->get['group'])) {
			$url .= '&group=' . $this->request->get['group'];
		}

		$pagination = new Pagination();
		$pagination->total = $totals;
		$pagination->page = $page;
		$pagination->limit = $limit;
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('service/company',  $url . '&page={page}');
	
		$this->data['pagination'] = $pagination->render_page();
		$this->data['text_totals'] = sprintf($this->language->get('text_totals'),$totals);
		$this->data['search'] = $filter_search;
		$this->data['group'] = $filter_group;

		
		$this->template = $this->config->get('config_template') . '/template/service/company.tpl';
		
		$this->children = array(
			'common/column_left',
            'common/column_right',
            'common/content_top',
            'common/content_bottom',
			'module/mini_login',
			'common/footer',
			'common/header'	
		);
						
		$this->response->setOutput($this->render());				
	}
  	public function apply() {

    	$this->language->load('service/company');

		$this->load->model('service/company');
			
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateApply()) {
			$this->model_service_company->addCompanyRequest($this->request->post);
			
      		$this->session->data['success'] = $this->language->get('text_apply_success');
      		$this->session->data['apply_phone'] = (isset($this->request->post['company_id']) ? $this->request->post['company_id'] : 0 ) . '_' . ( isset($this->request->post['company_id']) ? $this->customer->getMobilePhone() : $this->request->post['mobile_phone']);
      		$this->session->data['apply_time'] = time();

      		if(isset($this->request->post['redirect'])){
      			$this->redirect(htmlspecialchars_decode($this->request->post['redirect']));	
      		}
	  		$json = array('status'=>1,'msg'=>$this->language->get('text_apply_success'));
    	}else if(isset($this->error['error_login']) && $this->error['error_login']){
    		$url = '';
			if (isset($this->request->get['search'])) {
				$url .= '&search=' . $this->request->get['search'];
			}
			if (isset($this->request->get['company'])) {
				$url .= '&company=' . $this->request->get['company'];
			}
			if (isset($this->request->get['zone'])) {
				$url .= '&zone=' . $this->request->get['zone'];
			}
			if (isset($this->request->get['group'])) {
				$url .= '&group=' . $this->request->get['group'];
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
			$redirect = $this->url->link('service/company',$url,'SSL');
			if (isset($this->request->get['company_id']) || isset($this->request->post['company_id'])) {
				$url .= '&company_id=' . (isset($this->request->get['company_id']) ? $this->request->get['company_id'] : $this->request->post['company_id']);
				$redirect = $this->url->link('service/company/info',$url,'SSL');
			}   		

    		$json = array('status'=>0,'redirect'=>htmlspecialchars_decode($redirect));
    	}else{
    		$json = array('status'=>0,'error'=>implode("<br>", $this->error));
    	}
    	$this->response->setOutput(json_encode($json));

  	}

  	protected function validateApply() {
  		if(isset($this->request->post['company_id'])){
  			if(!$this->customer->isLogged()){
  				$this->error['error_login'] = true;
  			}
  		}else{
	    	if (!isset($this->request->post['mobile_phone']) || !isMobile($this->request->post['mobile_phone'])) {
	      		$this->error['mobile_phone'] = $this->language->get('error_mobile_phone');
	    	}
	    	
	    	if ((utf8_strlen($this->request->post['account']) < 2) || (utf8_strlen($this->request->post['account']) > 128)) {
	      		$this->error['account'] = $this->language->get('error_account');
	    	}
			
		}
		if(isset($this->session->data['apply_phone']) && $this->session->data['apply_phone'] == ((isset($this->request->post['company_id']) ? $this->request->post['company_id'] : 0 )  . '_' .(isset($this->request->post['company_id']) ? $this->customer->getMobilePhone() : $this->request->post['mobile_phone'])) && ($this->session->data['apply_time'] - time() < 3600)){
			$this->error['repeat'] = $this->language->get('error_repeat');	
		}
    	if (!$this->error) {
      		return true;
		} else {
      		return false;
    	}
  	}

	public function info() {  
    	$this->language->load('service/company');
		
		$this->load->model('service/company');
		$this->document->addStyle('market/view/theme/yuankong/stylesheet/yk_zt.css');
		$this->document->addStyle('market/view/theme/yuankong/stylesheet/yk.css');
		$this->data['breadcrumbs'] = array();
		
      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),
        	'separator' => false
      	);
		$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('service/company'),
        	'separator' => $this->language->get('text_separator')
      	);
		if (isset($this->request->get['company_id'])) {
			$company_id = (int)$this->request->get['company_id'];
		} else {
			$company_id = 0;
		}
		$this->load->model('tool/image');
		$company_info = $this->model_service_company->getCompany($company_id);
  		
		if ($company_info) {
			$this->document->setTitle($company_info['title']);
      		$this->data['breadcrumbs'][] = array(
        		'text'      => $company_info['title'],
				'href'      => $this->url->link('service/company', 'company_id=' .  $company_id),      		
        		'separator' => $this->language->get('text_separator')
      		);		
	
      		$this->data['heading_title'] = $company_info['title'];
      		$this->data['company_id'] = $company_id;
      		
      		$this->data['text_date_modified'] = $this->language->get('text_date_modified');
      		$this->data['text_viewed'] = $this->language->get('text_viewed');
			
			$this->data['title'] = html_entity_decode($company_info['title'], ENT_QUOTES, 'UTF-8');
			$this->data['logo'] = file_exists($company_info['logo']) ? $company_info['logo'] : $this->model_tool_image->resize('nopic.jpg', 100, 100);
			$this->data['cover'] = file_exists($company_info['cover']) ? $company_info['cover'] : $this->model_tool_image->resize('nopic.jpg', 480, 300);			
			$this->data['description'] = html_entity_decode($company_info['description'], ENT_QUOTES, 'UTF-8');
			$this->data['address'] = $company_info['area_zone'].' '.trim($company_info['address']);

			$this->data['viewed'] = (int)$company_info['viewed'];
			$this->data['recommend'] = (int)$company_info['recommend'];
			$this->data['deposit'] = (int)$company_info['deposit'];
			$this->data['modules'] = $this->data['cases'] = $this->data['members'] = array();

			$modules = $this->model_service_company->getCompanyModulesByCompanyId($company_id);
			foreach ($modules as $item) {
				if($item['status']){
					$item['image'] = file_exists($item['image']) ? $item['image'] : '';
					$this->data['modules'][]=$item;
				}
			}

			$cases = $this->model_service_company->getCompanyCasesByCompanyId($company_id);
			foreach ($cases as $item) {
				$item['photo'] = file_exists($item['photo']) ? $item['photo'] : $this->model_tool_image->resize('nopic.jpg',280,219);
				$this->data['cases'][]=$item;
			}
			
			$members = $this->model_service_company->getCompanyMembersByCompanyId($company_id);
			foreach ($members as $item) {
				$item['avatar'] = file_exists($item['avatar']) ? $item['avatar'] : $this->model_tool_image->resize('nopic.jpg',122,122);
				$this->data['members'][]=$item;
			}
      		$this->data['groups'] = $this->model_service_company->getCompanyGroupsByCompanyId($company_id);
      		$this->data['all_groups'] = $this->model_service_company->getCompanyGroups();
      		
			$this->data['continue'] = $this->url->link('common/home');

            $this->model_service_company->addCompanyViewed($company_id);

			$this->template = $this->config->get('config_template') . '/template/service/company_detail.tpl';
			
			$this->children = array(
				'module/mini_login',
				'common/footer',
				'common/header'
			);
						
	  		$this->response->setOutput($this->render());
    	} else {
      		$this->data['breadcrumbs'][] = array(
        		'text'      => $this->language->get('text_error'),
				'href'      => $this->url->link('service/company', 'company_id=' . $company_id),
        		'separator' => $this->language->get('text_separator')
      		);
				
	  		$this->document->setTitle($this->language->get('text_error'));
			
      		$this->data['heading_title'] = $this->language->get('text_error');

      		$this->data['text_error'] = $this->language->get('text_error');

      		$this->data['button_continue'] = $this->language->get('button_continue');

      		$this->data['continue'] = $this->url->link('common/home');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
			} else {
				$this->template = 'default/template/error/not_found.tpl';
			}
			
			$this->children = array(
				'common/column_left',
				'common/column_right',
				'common/content_top',
				'common/content_bottom',
				'common/footer',
				'common/header'
			);
					
	  		$this->response->setOutput($this->render());
    	}
  	}
}