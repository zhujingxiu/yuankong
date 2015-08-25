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
        $this->data['groups'] = array();
        $groups = $this->model_service_project->getProjectGroups();
        $this->load->model('tool/image');
        foreach ($groups as $item) {
        	$group = strtolower($item['keyword']);
        	$item['heading_title'] = $this->language->get('title_'.$group);
        	$item['template'] = 'project_'.$group;
        	$item['link'] = $this->url->link('service/project','group='.$group,'SSL');
        	$item['icon'] = $this->model_tool_image->resize($item['icon'],35,35);
        	$this->data['groups'][strtolower($item['keyword'])] = $item;
        }

        if(isset($this->data['groups'][$keyword])){
        	$this->document->setTitle($this->data['groups'][$keyword]['heading_title']);
            $template = $this->data['groups'][$keyword]['template'];
        }else{
        	$this->document->setTitle($this->language->get('heading_title'));
            $template = 'project';
        }

        $this->data['prefix'] = array(
        	'link'	=> $this->url->link('service/project','','SSL'),
        	'name'	=> $this->language->get('title_prefix'),
        	'icon'	=> $this->model_tool_image->resize('project_prefix.jpg',35,35)
        );

		$this->template = $this->config->get('config_template') . '/template/service/'.$template.'.tpl';
		
		$this->children = array(
			'common/footer',
			'common/header'	
		);
						
		$this->response->setOutput($this->render());				
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