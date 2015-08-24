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
				$result['logo'] = $this->model_tool_image->resize($result['logo'], 117, 117);
			} else {
				$result['logo'] = $this->model_tool_image->resize("nopic.jpg", 117, 117);
			}
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
      		$this->session->data['apply_phone'] = (isset($this->request->post['company_id']) ? $this->request->post['company_id'] : 0 ) . '_' . $this->request->post['mobile_phone'];
      		$this->session->data['apply_time'] = time();

      		if(isset($this->request->post['redirect'])){
      			$this->redirect(htmlspecialchars_decode($this->request->post['redirect']));	
      		}
	  		$json = array('status'=>1,'msg'=>$this->language->get('text_apply_success'));
    	}else{
    		$json = array('status'=>0,'error'=>implode("<br>", $this->error));
    	}
    	$this->response->setOutput(json_encode($json));

  	}

  	protected function validateApply() {
    	if (!isset($this->request->post['mobile_phone']) || !isMobile($this->request->post['mobile_phone'])) {
      		$this->error['mobile_phone'] = $this->language->get('error_mobile_phone');
    	}
    	if(!isset($this->request->post['group_id'])){
    		$this->request->post['group_id'] = 0;
    	}
    	if ((utf8_strlen($this->request->post['account']) < 2) || (utf8_strlen($this->request->post['account']) > 128)) {
      		$this->error['account'] = $this->language->get('error_account');
    	}
		if(isset($this->session->data['apply_phone']) && $this->session->data['apply_phone'] == ((isset($this->request->post['company_id']) ? $this->request->post['company_id'] : 0 )  . '_' .$this->request->post['mobile_phone']) && ($this->session->data['apply_time'] - time() < 3600)){
			$this->error['repeat'] = $this->language->get('error_repeat');	
		}
    	if (!$this->error) {
      		return true;
		} else {
      		return false;
    	}
  	}

  	public function info(){
  		
  	}
}