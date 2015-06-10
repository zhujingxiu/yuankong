<?php
class ControllerExtensionNews extends Controller {
	private $error = array();
	
	public function index() {
		$this->language->load('extension/news');
		$this->load->model('extension/news');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/news', 'token=' . $this->session->data['token'], 'SSL'),
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
		
		$url = '';
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
			$url .= '&page=' . $this->request->get['page'];
		} else { 
			$page = 1;
		}
		
		$data = array(
			'page' => $page,
			'limit' => $this->config->get('config_admin_limit'),
			'start' => $this->config->get('config_admin_limit') * ($page - 1),
		);
		
		$total = $this->model_extension_news->countNews();
		
		$pagination = new Pagination();
		$pagination->total = $total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('extension/news', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
		
		$this->data['pagination'] = $pagination->render();
		
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_title'] = $this->language->get('text_title');
		$this->data['text_subtitle'] = $this->language->get('text_subtitle');
		$this->data['text_from'] = $this->language->get('text_from');
		$this->data['text_date'] = $this->language->get('text_date');
		$this->data['text_action'] = $this->language->get('text_action');
		$this->data['text_edit'] = $this->language->get('text_edit');
		
		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_delete'] = $this->language->get('button_delete');
		
		$this->data['insert'] = $this->url->link('extension/news/insert', '&token=' . $this->session->data['token'], 'SSL');
		$this->data['delete'] = $this->url->link('extension/news/delete', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['news'] = array();
		
		$news = $this->model_extension_news->getAllNews($data);
		
		foreach ($news as $news) {
			$this->data['news'][] = array (
				'news_id' => $news['news_id'],
				'title' => $news['title'],
				'subtitle' => $news['subtitle'],
				'from' => $news['from'],
				'date_added' => date('Y-m-d H:i:s', strtotime($news['date_added'])),
				'edit' => $this->url->link('extension/news/edit', '&news_id=' . $news['news_id'] . '&token=' . $this->session->data['token'], 'SSL')
			);
		}
		
		$this->template = 'extension/news_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());		
	}
	
	public function edit() {
		$this->language->load('extension/news');
		$this->load->model('extension/news');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		if (isset($this->session->data['warning'])) {
			$this->data['error'] = $this->session->data['warning'];
		
			unset($this->session->data['warning']);
		} else {
			$this->data['error'] = '';
		}
		
		if (!isset($this->request->get['news_id'])) {
			$this->redirect($this->url->link('extension/news', '&token=' . $this->session->data['token'], 'SSL'));
		}
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_extension_news->editNews($this->request->get['news_id'], $this->request->post);		
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/news', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/news', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('extension/news/edit', '&news_id=' . $this->request->get['news_id'] . '&token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/news', '&token=' . $this->session->data['token'], 'SSL');
		$this->data['token'] = $this->session->data['token'];
		
		$this->form();
	}
	
	public function insert() {
		$this->language->load('extension/news');
		$this->load->model('extension/news');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		if (isset($this->session->data['warning'])) {
			$this->data['error'] = $this->session->data['warning'];
		
			unset($this->session->data['warning']);
		} else {
			$this->data['error'] = '';
		}
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_extension_news->addNews($this->request->post);		
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/news', 'token=' . $this->session->data['token'], 'SSL'));
		}
		
		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('extension/news', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('extension/news/insert', '&token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/news', '&token=' . $this->session->data['token'], 'SSL');
		$this->data['token'] = $this->session->data['token'];
		
		$this->form();
	}
	
	private function form() {
		$this->language->load('extension/news');
		$this->load->model('extension/news');
		
		
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
		
		
		if (isset($this->request->get['news_id'])) {
			$news = $this->model_extension_news->getNews($this->request->get['news_id']);
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
			$this->data['is_top'] = '';
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
			$this->data['status'] = '';
		}

		if (isset($this->request->post['sort_order'])) {
			$this->data['sort_order'] = $this->request->post['sort_order'];
		} elseif (!empty($news)) {
			$this->data['sort_order'] = $news['sort_order'];
		} else {
			$this->data['sort_order'] = '';
		}

		$this->load->model('extension/news_group');
		$this->data['groups'] = $this->model_extension_news_group->getNewsGroups();
		
		$this->template = 'extension/news_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	public function delete() {
		$this->language->load('extension/news');
		$this->load->model('extension/news');

		$this->document->setTitle($this->language->get('heading_title'));
		
		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $id) {
				$this->model_extension_news->deleteNews($id);
			}

			$this->session->data['success'] = $this->language->get('text_success');
		}
		
		$this->redirect($this->url->link('extension/news', 'token=' . $this->session->data['token'], 'SSL'));
	}
	
	private function validateDelete() {
		if (!$this->user->hasPermission('modify', 'extension/news')) {
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
		if (!$this->user->hasPermission('modify', 'extension/news')) {
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