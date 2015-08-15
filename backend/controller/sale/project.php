<?php
class ControllerSaleProject extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('sale/project');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('sale/project');

		$this->getList();
	}

	public function add() {
		$this->load->language('sale/project');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('sale/project');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_sale_project->addProject($this->request->post);

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

			$this->response->redirect($this->url->link('sale/project', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function edit() {
		$this->load->language('sale/project');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('sale/project');
		$json = array('status'=>0,'msg'=>$this->language->get('text_exception'));
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm('edit')) {

			$this->model_sale_project->changeProjectStatus($this->request->post['project_id'], $this->request->post['status']);
			$json = array('status'=>1,'msg'=>$this->language->get('text_success'));

			$this->session->data['success'] = $this->language->get('text_success');
		}
		$this->response->setOutput(json_encode($json));
	}

	public function delete() {
		$this->load->language('sale/project');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('sale/project');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $project_id) {
				$this->model_sale_project->deleteProject($project_id);
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

			$this->response->redirect($this->url->link('sale/project', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	protected function getList() {
		if (isset($this->request->get['tab'])) {
			$tab = $this->request->get['tab'];
		} else {
			$tab = 'all';
		}
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.date_modified';
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
		if (isset($this->request->get['tab'])) {
			$url .= '&tab=' . $this->request->get['tab'];
		}else{
			$url .= '&tab=all';
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
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('sale/project', 'token=' . $this->session->data['token'] . $url, 'SSL'),
			'separator' => '::'
		);

		$this->data['all'] = $this->url->link('sale/project', 'tab=all&token=' . $this->session->data['token'] , 'SSL');
		$this->data['undo'] = $this->url->link('sale/project', 'tab=undo&token=' . $this->session->data['token'] , 'SSL');
		$this->data['doing'] = $this->url->link('sale/project', 'tab=doing&token=' . $this->session->data['token'] , 'SSL');
		$this->data['done'] = $this->url->link('sale/project', 'tab=done&token=' . $this->session->data['token'] , 'SSL');

		$this->data['delete'] = $this->url->link('sale/project/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['projects'] = array();

		$filter_data = array(
			'tab'	=> $tab,
			'sort'  => $sort,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);

		$project_total = $this->model_sale_project->getTotalProjects($filter_data);

		$results = $this->model_sale_project->getProjects($filter_data);

		foreach ($results as $result) {
			$action = array();
						
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => 'javascript:changeStatus('.(int)$result['project_id'].','.(int)$result['status'].')'
			);

			$this->data['projects'][] = array(
				'project_id' => $result['project_id'],
				'project_sn' => $result['project_sn'] ,
				'group'      => $result['group_name'],
				'telephone'	 => $result['telephone'],
				'account'	 => $result['account'],
				'date_applied'=> date('Y-m-d H:i:s',strtotime($result['date_applied'])),
				'selected'   => isset($this->request->post['selected']) && in_array($result['project_id'], $this->request->post['selected']),
				'action'      => $action
			);
		}

		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_list'] = $this->language->get('text_list');
		$this->data['text_title'] = $this->language->get('text_title');
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		$this->data['text_confirm'] = $this->language->get('text_confirm');
		$this->data['tab_all'] = $this->language->get('tab_all');
		$this->data['tab_pending'] = $this->language->get('tab_pending');
		$this->data['tab_processing'] = $this->language->get('tab_processing');
		$this->data['tab_processed'] = $this->language->get('tab_processed');

		$this->data['column_project_sn'] = $this->language->get('column_project_sn');
		$this->data['column_account'] = $this->language->get('column_account');
		$this->data['column_phone'] = $this->language->get('column_phone');
		$this->data['column_category'] = $this->language->get('column_category');
		$this->data['column_date_applied'] = $this->language->get('column_date_applied');
		$this->data['column_action'] = $this->language->get('column_action');

		$this->data['entry_status'] = $this->language->get('entry_status');

		$this->data['button_add'] = $this->language->get('button_add');
		$this->data['button_edit'] = $this->language->get('button_edit');
		$this->data['button_delete'] = $this->language->get('button_delete');
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_close'] = $this->language->get('button_close');

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

		if (isset($this->request->post['selected'])) {
			$this->data['selected'] = (array)$this->request->post['selected'];
		} else {
			$this->data['selected'] = array();
		}

		$url = '';
		if (isset($this->request->get['tab'])) {
			$url .= '&tab=' . $this->request->get['tab'];
		}else{
			$url .= '&tab=all';
		}
		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$this->data['sort_sn'] = $this->url->link('sale/project', 'token=' . $this->session->data['token'] . '&sort=p.project_sn' . $url, 'SSL');
		$this->data['sort_date_applied'] = $this->url->link('sale/project', 'token=' . $this->session->data['token'] . '&sort=p.date_applied' . $url, 'SSL');

		$url = '';
		if (isset($this->request->get['tab'])) {
			$url .= '&tab=' . $this->request->get['tab'];
		}else{
			$url .= '&tab=all';
		}
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $project_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_admin_limit');
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = HTTPS_SERVER . 'index.php?route=sale/project&token=' . $this->session->data['token'] . $url . '&page={page}';

		$this->data['pagination'] = $pagination->render();

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;
		$this->data['tab'] = $tab;
		$this->data['token'] = $this->session->data['token'];

		$this->template = 'sale/project_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}

	protected function getForm() {
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_form'] = !isset($this->request->get['project_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');

		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_description'] = $this->language->get('entry_description');
		$this->data['entry_approval'] = $this->language->get('entry_approval');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['help_approval'] = $this->language->get('help_approval');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = array();
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
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('sale/project', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		if (!isset($this->request->get['project_id'])) {
			$this->data['action'] = $this->url->link('sale/project/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('sale/project/edit', 'token=' . $this->session->data['token'] . '&project_id=' . $this->request->get['project_id'] . $url, 'SSL');
		}

		$this->data['cancel'] = $this->url->link('sale/project', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['project_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$project_info = $this->model_sale_project->getProject($this->request->get['project_id']);
		}

		$this->load->model('localisation/language');

		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		if (isset($this->request->post['project_description'])) {
			$this->data['project_description'] = $this->request->post['project_description'];
		} elseif (isset($this->request->get['project_id'])) {
			$this->data['project_description'] = $this->model_sale_project->getProjectDescriptions($this->request->get['project_id']);
		} else {
			$this->data['project_description'] = array();
		}

		if (isset($this->request->post['approval'])) {
			$this->data['approval'] = $this->request->post['approval'];
		} elseif (!empty($project_info)) {
			$this->data['approval'] = $project_info['approval'];
		} else {
			$this->data['approval'] = '';
		}

		if (isset($this->request->post['sort_order'])) {
			$this->data['sort_order'] = $this->request->post['sort_order'];
		} elseif (!empty($project_info)) {
			$this->data['sort_order'] = $project_info['sort_order'];
		} else {
			$this->data['sort_order'] = '';
		}

		$this->template = 'sale/project_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify','sale/project/')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify','sale/project/'))  {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}