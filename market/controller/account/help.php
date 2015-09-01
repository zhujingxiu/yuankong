<?php
class ControllerAccountHelp extends Controller {
	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/help', '', 'SSL');
			
	  		$this->redirect($this->url->link('account/login', '', 'SSL'));
    	}		
		
		$this->language->load('account/help');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addScript('market/view/theme/yuankong/javascript/click.js');
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
		
      	$this->data['breadcrumbs'][] = array(       	
        	'text'      => $this->language->get('text_help'),
			'href'      => $this->url->link('account/help', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);
		
		$this->load->model('account/help');

    	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['column_date_added'] = $this->language->get('column_date_added');
		$this->data['column_description'] = $this->language->get('column_description');
		$this->data['column_amount'] = sprintf($this->language->get('column_amount'), $this->config->get('config_currency'));
		
		$this->data['text_total'] = $this->language->get('text_total');
		$this->data['text_empty'] = $this->language->get('text_empty');
		
		$this->data['button_continue'] = $this->language->get('button_continue');
				
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}		
		
		$this->data['helps'] = array();
		
		$data = array(				  
			'sort'  => 'date_added',
			'order' => 'DESC',
			'start' => ($page - 1) * 10,
			'limit' => 10
		);
		
		$help_total = $this->model_account_help->getTotalHelps($data);
	
		$results = $this->model_account_help->getHelps($data);
 		
    	foreach ($results as $result) {
			$this->data['helps'][] = array(
				'link'      => $this->url->link('information/wiki/help','wiki_group=help&help_id='.$result['help_id']),
				'text'      => $result['text'],
				'reply' 	=> $result['reply'],
				'replied' 	=> strtotime($result['date_replied']),
				'date_added'  => date('Y-m-d', strtotime($result['date_added'])),
				'date_replied'  => date('Y-m-d', strtotime($result['date_replied'])),
			);
		}	

		$pagination = new Pagination();
		$pagination->total = $help_total;
		$pagination->page = $page;
		$pagination->limit = 10; 
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('account/help', 'page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render_page();
				
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/help.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/help.tpl';
		} else {
			$this->template = 'default/template/account/help.tpl';
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
