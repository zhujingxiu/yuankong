<?php 
class ControllerServiceCompany extends Controller {
	private $error = array();
		
	public function index() {
		$this->language->load('service/company');
		$this->load->model('service/company');

		$this->load->model('tool/image'); 

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
		
		$url = '';
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

		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['entry_type'] = $this->language->get('entry_type');

		$filter_data = array(
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

		$this->data['zones'] = $this->model_service_company->getCompanyZones();
		$this->data['groups'] = $this->model_service_company->getCompanyGroups();
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

}