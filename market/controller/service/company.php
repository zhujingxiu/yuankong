<?php 
class ControllerServiceCompany extends Controller {
	private $error = array();
		
	public function index() {
		$this->language->load('service/company');

        $this->document->setTitle($this->language->get('heading_title'));
		$this->document->addStyle('market/view/theme/yuankong/stylesheet/yk_zt.css');
		$this->document->addScript('market/view/theme/yuankong/javascript/validation.js');
      	$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),        	
        	'separator' => false
      	); 

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_account'),
			'href'      => $this->url->link('account/account', '', 'SSL'),        	
        	'separator' => $this->language->get('text_separator')
      	);
		
		$url = '';
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
				
      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('service/company', $url, 'SSL'),        	
        	'separator' => $this->language->get('text_separator')
      	);

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['column_telephone'] = $this->language->get('column_telephone');
		$this->data['column_account'] = $this->language->get('column_account');
		$this->data['column_group'] = $this->language->get('column_group');
		$this->data['column_status'] = $this->language->get('column_status');
		$this->data['column_date_applied'] = $this->language->get('column_date_applied');

		$this->data['action'] = $this->url->link('service/company', '', 'SSL');
		$this->data['button_view'] = $this->language->get('button_view');


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