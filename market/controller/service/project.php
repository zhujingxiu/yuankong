<?php 
class ControllerServiceProject extends Controller {
	private $error = array();
		
	public function index() {

		
		$this->language->load('service/project');
		
        
        $this->document->addStyle('market/view/theme/yuankong/stylesheet/yk_zt.css');
        $this->document->addScript('market/view/theme/yuankong/javascript/validation.js');
        $this->load->model('service/project');

        $this->data['heading_title'] = $this->language->get('heading_title');
        $this->data['column_telephone'] = $this->language->get('column_telephone');
        $this->data['column_account'] = $this->language->get('column_account');
        $this->data['column_group'] = $this->language->get('column_group');
        $this->data['column_status'] = $this->language->get('column_status');
        $this->data['column_date_applied'] = $this->language->get('column_date_applied');

        $this->data['action'] = $this->url->link('service/project/apply', '', 'SSL');
        $this->data['button_view'] = $this->language->get('button_view');
        
        $keyword = isset($this->request->get['group']) ? strtolower(trim($this->request->get['group'])) : 'index';
        $group_id = $this->model_service_project->getProjectIdByKeyword($keyword);
        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }
        
        $this->data['group_id'] = $group_id;
        $this->data['projects'] = array();
        
        $total = $this->model_service_project->getTotalProjects($group_id);
        
        $results = $this->model_service_project->getProjects($group_id,($page - 1) * 10, 10);
        
        foreach ($results as $result) {
            if(isset($result['status'])){
                switch ((int)$result['status']) {
                    case 1:
                        $status_text = $this->language->get('text_project_pending');
                        break;
                    case 2:
                        $status_text = $this->language->get('text_project_processing');
                        break;
                    case 3:
                        $status_text = $this->language->get('text_project_completed');
                        break;
                    default:
                        $status_text = $this->language->get('text_unknown');
                        break;
                }
                $result['status_text'] = $status_text;
            }
            $result['group'] = $result['name'];
            $result['date_applied'] = date('Y-m-d',strtotime($result['date_applied']));
            $result['telephone'] = substr_replace($result['telephone'],'****',3,4);
            $this->data['projects'][] = $result;
        }

        $this->data['groups'] = $this->model_service_project->getProjectGroups();

        switch ($keyword) {
            case 'design':
                $this->document->setTitle($this->language->get('title_design'));
                $template = 'project_design';
                break;
            case 'project':
                $this->document->setTitle($this->language->get('title_project'));
                $template = 'project_project';
                break;
            case 'check':
                $this->document->setTitle($this->language->get('title_check'));
                $template = 'project_check';
                break;
            case 'approve':
                $this->document->setTitle($this->language->get('title_approve'));
                $template = 'project_approve';
                break;
            case 'maintenance':
                $this->document->setTitle($this->language->get('title_maintenance'));
                $template = 'project_maintenance';
                break;
            case 'trusteeship':
                $this->document->setTitle($this->language->get('title_trusteeship'));
                $template = 'project_trusteeship';
                break;
            case 'train':
                $this->document->setTitle($this->language->get('title_train'));
                $template = 'project_train';
                break;
            case 'guarantee':
                $this->document->setTitle($this->language->get('title_guarantee'));
                $template = 'project_guarantee';
                break;
            default:
                $this->document->setTitle($this->language->get('heading_title'));
                $template = 'project';
                break;
        }


		$this->template = $this->config->get('config_template') . '/template/service/'.$template.'.tpl';
		
		$this->children = array(
			'common/footer',
			'common/header'	
		);
						
		$this->response->setOutput($this->render());				
	}


	
	public function info() { 
		$this->language->load('service/project');
		
		if (isset($this->request->get['project_id'])) {
			$project_id = $this->request->get['project_id'];
		} else {
			$project_id = 0;
		}	

		$this->load->model('service/project');
			
		$project_info = $this->model_service_project->getProject($project_id);
		
		if ($project_info) {
			$this->document->setTitle($this->language->get('text_order'));
			
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
				'href'      => $this->url->link('service/project', $url, 'SSL'),      	
				'separator' => $this->language->get('text_separator')
			);
			
			$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_order'),
				'href'      => $this->url->link('service/project/info', 'project_id=' . $this->request->get['project_id'] . $url, 'SSL'),
				'separator' => $this->language->get('text_separator')
			);
					
      		$this->data['heading_title'] = $this->language->get('text_order');
			
    		$this->data['text_project_id'] = $this->language->get('text_project_id');
			$this->data['text_date_added'] = $this->language->get('text_date_added');
      		$this->data['text_history'] = $this->language->get('text_history');
			$this->data['text_comment'] = $this->language->get('text_comment');

      		$this->data['column_name'] = $this->language->get('column_name');
      		$this->data['column_model'] = $this->language->get('column_model');
      		$this->data['column_quantity'] = $this->language->get('column_quantity');
      		$this->data['column_total'] = $this->language->get('column_total');
			$this->data['column_action'] = $this->language->get('column_action');
			$this->data['column_date_added'] = $this->language->get('column_date_added');
      		$this->data['column_status'] = $this->language->get('column_status');
			
      		$this->data['button_continue'] = $this->language->get('button_continue');
		

			
			$this->data['project_id'] = $this->request->get['project_id'];
			$this->data['date_added'] = date($this->language->get('date_format_short'), strtotime($project_info['date_added']));
			


      		$this->data['continue'] = $this->url->link('service/project', '', 'SSL');
      		$this->data['action'] = $this->url->link('service/project/apply', '', 'SSL');
		
			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/service/project_info.tpl')) {
				$this->template = $this->config->get('config_template') . '/template/service/project_info.tpl';
			} else {
				$this->template = 'default/template/service/project_info.tpl';
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
    	} else {
			$this->document->setTitle($this->language->get('text_order'));
			
      		$this->data['heading_title'] = $this->language->get('text_order');

      		$this->data['text_error'] = $this->language->get('text_error');

      		$this->data['button_continue'] = $this->language->get('button_continue');
			
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
				'text'      => $this->language->get('heading_title'),
				'href'      => $this->url->link('service/project', '', 'SSL'),
				'separator' => $this->language->get('text_separator')
			);
			
			$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_order'),
				'href'      => $this->url->link('service/project/info', 'project_id=' . $project_id, 'SSL'),
				'separator' => $this->language->get('text_separator')
			);
												
      		$this->data['continue'] = $this->url->link('service/project', '', 'SSL');
			 			
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


  	public function apply() {

    	$this->language->load('service/project');

		$this->load->model('service/project');

    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateApply()) {
			$this->model_service_project->addProject($this->request->post);
			
      		$this->session->data['success'] = $this->language->get('text_apply_success');
      		$this->session->data['apply_phone'] = $this->request->post['group_id'] . '_' . $this->request->post['telephone'];
      		$this->session->data['apply_time'] = time();
      		$json = array('status'=>1,'msg'=>$this->language->get('text_apply_success'));
    	}else{
    		$json = array('status'=>0,'error'=>implode("<br>", $this->error));
    	}
    	$this->response->setOutput(json_encode($json));
  	}

  	protected function validateApply() {
    	if (!isset($this->request->post['telephone']) || !isMobile($this->request->post['telephone'])) {
      		$this->error['telephone'] = $this->language->get('error_telephone');
    	}
    	if(!isset($this->request->post['group_id'])){
    		$this->request->post['group_id'] = 0;
    	}
    	if ((utf8_strlen($this->request->post['account']) < 2) || (utf8_strlen($this->request->post['account']) > 128)) {
      		$this->error['account'] = $this->language->get('error_account');
    	}
		if(isset($this->session->data['apply_phone']) && $this->session->data['apply_phone'] == ($this->request->post['group_id'] . '_' .$this->request->post['telephone']) && ($this->session->data['apply_time'] - time() < 3600)){
			$this->error['repeat'] = $this->language->get('error_repeat');	
		}
    	if (!$this->error) {
      		return true;
		} else {
      		return false;
    	}
  	}
}