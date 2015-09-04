<?php
class ControllerAccountMessage extends Controller {
	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/message', '', 'SSL');
			
	  		$this->redirect($this->url->link('account/login', '', 'SSL'));
    	}		
		
		$this->language->load('account/message');

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
        	'text'      => $this->language->get('text_message'),
			'href'      => $this->url->link('account/message', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);
		
		$this->load->model('account/message');

    	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_total'] = $this->language->get('text_total');
		$this->data['text_empty'] = $this->language->get('text_empty');
		
		$this->data['button_continue'] = $this->language->get('button_continue');
				
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}		
		
		$this->data['messages'] = array();
		
		$data = array(				  
			'sort'  => 'date_added',
			'order' => 'DESC',
			'start' => ($page - 1) * 10,
			'limit' => 10
		);
		
		$message_total = $this->model_account_message->getTotalMessages($data);
	
		$results = $this->model_account_message->getMessages($data);
 		
    	foreach ($results as $result) {
			$this->data['messages'][] = array(
				'message_id'    => $result['message_id'],
				'subject'      	=> $result['subject'],
				'text'      	=> $result['text'],
				'read' 			=> $result['read'],
				'date_added'  	=> date('Y-m-d H:i', strtotime($result['date_added']))
			);
		}	

		$pagination = new Pagination();
		$pagination->total = $message_total;
		$pagination->page = $page;
		$pagination->limit = 10; 
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('account/message', 'page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render_page();
		
		
		$this->data['continue'] = $this->url->link('account/account', '', 'SSL');
		
		$this->template = $this->config->get('config_template') . '/template/account/message.tpl';
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/footer',
			'common/header'	
		);
						
		$this->response->setOutput($this->render());		
	} 		

	public function setRead(){
		$message = isset($this->request->get['message_id']) ? $this->request->get['message_id'] : false;
		if($message){
			$this->load->model('account/message');
			$this->model_account_message->updateRead($message);
		}
	}

	public function delete(){
		$message = isset($this->request->get['message_id']) ? $this->request->get['message_id'] : false;
		if($message){
			$this->load->model('account/message');
			$this->model_account_message->deleteMessage($message);
		}
	}
}
