<?php
class ControllerExtensionWiki extends Controller {
	private $error = array();
	
	public function index() {
		$this->language->load('extension/wiki');
		$this->load->model('extension/wiki');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/wiki', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);


		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		if (isset($this->session->data['warning'])) {
			$this->data['error'] = $this->session->data['warning'];
		
			unset($this->session->data['warning']);
		} else {
			$this->data['error'] = '';
		}
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'w.date_added';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'DESC';
		}
		$url = '';
		$tab = false;
		if (isset($this->request->get['tab'])) {
			$tab = $this->request->get['tab'];
			$url .= '&tab=' . $this->request->get['tab'];
		}
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
			$url .= '&page=' . $this->request->get['page'];
		} else { 
			$page = 1;
		}
		$this->load->model('extension/wiki_group');
		$this->data['groups'] = $this->model_extension_wiki_group->getWikiGroups();
		foreach ($this->data['groups'] as $key => $item) {
			if($item['group_id']){
				$this->data['groups'][$key]['link'] = $this->url->link('extension/wiki','tab='.$item['group_id'].'&token='.$this->session->data['token'],'SSL');
			}
			if($tab===false){
				$tab =  $item['group_id'] ;
			}
		}		
		
		$data = array(
			'tab' => $tab,
			'page' => $page,
			'limit' => $this->config->get('config_admin_limit'),
			'start' => $this->config->get('config_admin_limit') * ($page - 1),
		);
		
		$total = $this->model_extension_wiki->countWiki($data);
		
		$pagination = new Pagination();
		$pagination->total = $total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('extension/wiki', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
		
		$this->data['pagination'] = $pagination->render();
		
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_group'] = $this->language->get('text_group');
		$this->data['text_title'] = $this->language->get('text_title');
		$this->data['text_subtitle'] = $this->language->get('text_subtitle');
		$this->data['text_from'] = $this->language->get('text_from');
		$this->data['text_date'] = $this->language->get('text_date');
		$this->data['text_sort'] = $this->language->get('text_sort_order');
		$this->data['text_action'] = $this->language->get('text_action');
		$this->data['text_edit'] = $this->language->get('text_edit');
		
		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_delete'] = $this->language->get('button_delete');
		
		$this->data['insert'] = $this->url->link('extension/wiki/insert', '&token=' . $this->session->data['token'], 'SSL');
		$this->data['delete'] = $this->url->link('extension/wiki/delete', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['allwiki'] = array();
		
		$allwiki = $this->model_extension_wiki->getAllWiki($data);
		
		foreach ($allwiki as $item) {
			$this->data['allwiki'][] = array (
				'wiki_id' => $item['wiki_id'],
				'title' => $item['title'],
				'group' => $item['name'],
				'subtitle' => $item['subtitle'],
				'from' => $item['from'],
				'sort_order' => $item['sort_order'],
				'date_added' => date('Y-m-d H:i:s', strtotime($item['date_added'])),
				'edit' => $this->url->link('extension/wiki/edit', '&wiki_id=' . $item['wiki_id'] . '&token=' . $this->session->data['token'], 'SSL')
			);
		}
		

		$url = '';
		if (isset($this->request->get['tab'])) {
			$url .= '&tab=' . $this->request->get['tab'];
		}else{
			$url .= '&tab='.$tab;
		}
		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$this->data['sort_order'] = $this->url->link('extension/wiki', 'token=' . $this->session->data['token'] . '&sort=w.sort_order' . $url, 'SSL');
		$this->data['sort_title'] = $this->url->link('extension/wiki', 'token=' . $this->session->data['token'] . '&sort=w.title' . $url, 'SSL');
		$this->data['sort_date_added'] = $this->url->link('extension/wiki', 'token=' . $this->session->data['token'] . '&sort=w.date_added' . $url, 'SSL');
		$this->data['tab'] = $tab;
		$this->data['sort'] = $sort;
		$this->data['order'] = $order;
		$this->template = 'extension/wiki_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());		
	}
	
	public function edit() {
		$this->language->load('extension/wiki');
		$this->load->model('extension/wiki');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		if (isset($this->session->data['warning'])) {
			$this->data['error'] = $this->session->data['warning'];
		
			unset($this->session->data['warning']);
		} else {
			$this->data['error'] = '';
		}
		
		if (!isset($this->request->get['wiki_id'])) {
			$this->redirect($this->url->link('extension/wiki', '&token=' . $this->session->data['token'], 'SSL'));
		}
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_extension_wiki->editWiki($this->request->get['wiki_id'], $this->request->post);		
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/wiki', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/wiki', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('extension/wiki/edit', '&wiki_id=' . $this->request->get['wiki_id'] . '&token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/wiki', '&token=' . $this->session->data['token'], 'SSL');
		$this->data['token'] = $this->session->data['token'];
		
		$this->form();
	}
	
	public function insert() {
		$this->language->load('extension/wiki');
		$this->load->model('extension/wiki');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		if (isset($this->session->data['warning'])) {
			$this->data['error'] = $this->session->data['warning'];
		
			unset($this->session->data['warning']);
		} else {
			$this->data['error'] = '';
		}
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_extension_wiki->addWiki($this->request->post);		
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/wiki', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/wiki', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('extension/wiki/insert', '&token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/wiki', '&token=' . $this->session->data['token'], 'SSL');
		$this->data['token'] = $this->session->data['token'];
		
		$this->form();
	}
	
	private function form() {
		$this->language->load('extension/wiki');
		$this->load->model('extension/wiki');
		
		
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_group'] = $this->language->get('text_group');
		$this->data['text_title'] = $this->language->get('text_title');
		$this->data['text_subtitle'] = $this->language->get('text_subtitle');
		$this->data['text_status'] = $this->language->get('text_status');
		$this->data['text_from'] = $this->language->get('text_from');
		$this->data['text_text'] = $this->language->get('text_text');
		$this->data['text_top'] = $this->language->get('text_top');
		$this->data['text_sort_order'] = $this->language->get('text_sort_order');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		
		$this->data['button_submit'] = $this->language->get('button_submit');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		
		
		if (isset($this->request->get['wiki_id'])) {
			$news = $this->model_extension_wiki->getWiki($this->request->get['wiki_id']);
		} else {
			$news = '';
		}
		
		if (isset($this->request->post['title'])) {
			$this->data['title'] = $this->request->post['title'];
		} elseif (!empty($news)) {
			$this->data['title'] = $news['title'];
		} else {
			$this->data['title'] = '';
		}
		
		if (isset($this->request->post['subtitle'])) {
			$this->data['subtitle'] = $this->request->post['subtitle'];
		} elseif (!empty($news)) {
			$this->data['subtitle'] = $news['subtitle'];
		} else {
			$this->data['subtitle'] = '';
		}

		if (isset($this->request->post['from'])) {
			$this->data['from'] = $this->request->post['from'];
		} elseif (!empty($news)) {
			$this->data['from'] = $news['from'];
		} else {
			$this->data['from'] = '';
		}
		
		if (isset($this->request->post['text'])) {
			$this->data['text'] = $this->request->post['text'];
		} elseif (!empty($news)) {
			$this->data['text'] = $news['text'];
		} else {
			$this->data['text'] = '';
		}

		if (isset($this->request->post['is_top'])) {
			$this->data['is_top'] = $this->request->post['is_top'];
		} elseif (!empty($news)) {
			$this->data['is_top'] = $news['is_top'];
		} else {
			$this->data['is_top'] = 0;
		}

		if (isset($this->request->post['group_id'])) {
			$this->data['group_id'] = $this->request->post['group_id'];
		} elseif (!empty($news)) {
			$this->data['group_id'] = $news['group_id'];
		} else {
			$this->data['group_id'] = '';
		}

		if (isset($this->request->post['status'])) {
			$this->data['status'] = $this->request->post['status'];
		} elseif (!empty($news)) {
			$this->data['status'] = $news['status'];
		} else {
			$this->data['status'] = 1;
		}

		if (isset($this->request->post['sort_order'])) {
			$this->data['sort_order'] = $this->request->post['sort_order'];
		} elseif (!empty($news)) {
			$this->data['sort_order'] = $news['sort_order'];
		} else {
			$this->data['sort_order'] = 1;
		}

		$this->load->model('extension/wiki_group');
		$this->data['groups'] = $this->model_extension_wiki_group->getWikiGroups();
		
		$this->template = 'extension/wiki_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	public function delete() {
		$this->language->load('extension/wiki');
		$this->load->model('extension/wiki');

		$this->document->setTitle($this->language->get('heading_title'));
		
		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $id) {
				$this->model_extension_wiki->deleteWiki($id);
			}

			$this->session->data['success'] = $this->language->get('text_success');
		}
		
		$this->redirect($this->url->link('extension/wiki', 'token=' . $this->session->data['token'], 'SSL'));
	}
	
	private function validateDelete() {
		if (!$this->user->hasPermission('modify', 'extension/wiki')) {
			$this->error['warning'] = $this->language->get('error_permission');
			
			$this->session->data['warning'] = $this->language->get('error_permission');
		}
 
		if (!$this->error) {
			return true; 
		} else {
			return false;
		}
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'extension/wiki')) {
			$this->error['warning'] = $this->language->get('error_permission');
			$this->session->data['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}