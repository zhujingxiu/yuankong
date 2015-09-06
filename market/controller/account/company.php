<?php
class ControllerAccountCompany extends Controller {
	private $error = array();

	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/company', '', 'SSL');

			$this->redirect($this->url->link('account/login', '', 'SSL'));
		}

		$this->language->load('account/company');
		
		$this->document->setTitle($this->language->get('heading_title'));
        $this->document->addScript($this->area_js());
        $this->document->addScript(TPL_JS.'ajaxupload.js');
        $this->document->addScript('market/view/theme/yuankong/javascript/click.js');
        $this->document->addScript(TPL_JS.'validation/dist/jquery.validate.js');
        $this->document->addScript(TPL_JS.'validation/dist/localization/messages_zh.js');
        $this->document->addScript('market/view/theme/yuankong/javascript/company.js');
        $this->document->addStyle('market/view/theme/yuankong/stylesheet/yk_validate.css');
        $this->load->model('service/company');
        $this->load->model('tool/image');
		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_your_details'] = $this->language->get('text_your_details');

        $this->data['action'] = $this->url->link('account/company/index', '', 'SSL');
        $this->data['bind'] = $this->url->link('account/bind', '', 'SSL');
        $company_id = $this->customer->isCompany();

		if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validateCompany()) {
            $this->model_service_company->editCompany($company_id,$this->request->post);
            $this->session->data['success'] = $this->language->get('text_success_company');
            $this->redirect($this->url->link('account/company', '', 'SSL'));
        }

        $company_info = $this->model_service_company->getCompany($company_id);

        if(isset($this->error['email'])){
            $this->data['error_email'] = $this->error['email'];
        }else{
            $this->data['error_email'] = '';
        }

        if(isset($this->error['title'])){
            $this->data['error_title'] = $this->error['title'];
        }else{
            $this->data['error_title'] = '';
        }

        if(isset($this->error['corporation'])){
            $this->data['error_corporation'] = $this->error['corporation'];
        }else{
            $this->data['error_corporation'] = '';
        }

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

        if (isset($company_info['mobile_phone'])) {
            $this->data['mobile_phone'] = $company_info['mobile_phone'];
        } else {
            $this->data['mobile_phone'] = '';
        }
        if (isset($this->request->post['email'])) {
            $this->data['email'] = $this->request->post['email'];
        } else if (isset($company_info['email'])) {
            $this->data['email'] = $company_info['email'];
        } else {
            $this->data['email'] = '';
        }
        if (isset($this->request->post['code'])) {
            $this->data['code'] = $this->request->post['code'];
        } else if (isset($company_info['code'])) {
            $this->data['code'] = $company_info['code'];
        } else {
            $this->data['code'] = '';
        }
        $this->data['thumb'] =  $this->model_tool_image->resize('nopic.jpg',95,95);
		if (isset($this->request->post['logo'])) {
            $this->data['logo'] = $this->request->post['logo'];
        } else if (isset($company_info['logo']) && file_exists($company_info['logo'])) {
            $this->data['logo'] = $company_info['logo'];
			$this->data['thumb'] = $company_info['logo'];
		} else {
			$this->data['logo'] = '';
		}

		if (isset($this->request->post['corporation'])) {
			$this->data['corporation'] = $this->request->post['corporation'];
		} else if (isset($company_info['corporation'])) {
			$this->data['corporation'] = $company_info['corporation'];
		} else {
			$this->data['corporation'] = '';
		}

        if (isset($this->request->post['title'])) {
            $this->data['title'] = $this->request->post['title'];
        } else if (isset($company_info['title'])) {
            $this->data['title'] = $company_info['title'];
        } else {
            $this->data['title'] = '';
        }

        if (isset($this->request->post['address'])) {
            $this->data['address'] = $this->request->post['address'];
        } else if (isset($company_info['address'])) {
            $this->data['address'] = $company_info['address'];
        } else {
            $this->data['address'] = '';
        }

        if (isset($this->request->post['area_zone'])) {
            $this->data['area_zone'] = $this->request->post['area_zone'];
        } else if (isset($company_info['area_zone'])) {
            $this->data['area_zone'] = $company_info['area_zone'];
        } else {
            $this->data['area_zone'] = '';
        }

        if (isset($company_info['recommend'])) {
            $this->data['recommend'] = $company_info['recommend'];
        } else {
            $this->data['recommend'] = '';
        }

        if (isset($company_info['deposit'])) {
            $this->data['deposit'] = $company_info['deposit'];
        } else {
            $this->data['deposit'] = '';
        }
        if (isset($this->request->post['zone_id'])) {
            $this->data['zone_id'] = $this->request->post['zone_id'];
        } else if (isset($company_info['zone_id'])) {
            $this->data['zone_id'] = $company_info['zone_id'];
        } else {
            $this->data['zone_id'] = 0;
        }
        $this->data['zones'] = $this->model_service_company->getCompanyZones();
        $this->data['groups'] = $this->model_service_company->getCompanyGroupsByCompanyId($company_id);
        $this->data['all_groups'] = $this->model_service_company->getCompanyGroups();
        $this->data['no_photo'] = $this->model_tool_image->resize('nopic.jpg',95,95);
        $this->template = $this->config->get('config_template') . '/template/account/company.tpl';
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/footer',
			'common/header'	
		);
						
		$this->response->setOutput($this->render());	
	}

    public function description() {
        if (!$this->customer->isLogged()) {
            $this->session->data['redirect'] = $this->url->link('account/company', '', 'SSL');

            $this->redirect($this->url->link('account/login', '', 'SSL'));
        }

        $this->language->load('account/company');
        
        $this->document->setTitle($this->language->get('title_description'));
        $this->document->addScript(TPL_JS.'ajaxupload.js');
        $this->load->model('service/company');
        $this->load->model('tool/image');
        
        $this->data['heading_title'] = $this->language->get('title_description');

        $this->data['bind'] = $this->url->link('account/bind', '', 'SSL');
        $this->data['action'] = $this->url->link('account/company/description', '', 'SSL');

        $company_id = $this->customer->isCompany();
        if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validateDescription()) {
            $this->model_service_company->editDescription($company_id,$this->request->post); 
            $this->session->data['success']  = $this->language->get('text_success_description');
            $this->redirect($this->url->link('account/company/description'),'','SSL');
        }
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }  

        if (isset($this->session->data['success'])) {
            $this->data['error_success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        } else {
            $this->data['error_success'] = '';
        }  
        $company_info = $this->model_service_company->getCompany($company_id);
        if (isset($this->request->post['description'])) {
            $this->data['description'] = $this->request->post['description'];
        } else if (isset($company_info['description'])) {
            $this->data['description'] = $company_info['description'];
        } else {
            $this->data['description'] = '';
        }

        $this->data['thumb'] = $this->model_tool_image->resize('nopic.jpg',280,175);
        if (isset($company_info['cover']) && file_exists($company_info['cover'])) {
            $this->data['cover'] = $this->data['thumb'] =  $company_info['cover'];
        } else {
            $this->data['cover'] = '';
        }
        
        $this->data['no_photo'] = $this->model_tool_image->resize('nopic.jpg',280,175);
        $this->template = $this->config->get('config_template') . '/template/account/company_description.tpl';
        $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/footer',
            'common/header' 
        );
                        
        $this->response->setOutput($this->render());    
    }

    public function file(){
        if (!$this->customer->isLogged()) {
            $this->session->data['redirect'] = $this->url->link('account/company', '', 'SSL');

            $this->redirect($this->url->link('account/login', '', 'SSL'));
        }

        $this->language->load('account/company');
        
        $this->document->setTitle($this->language->get('title_file'));
        $this->document->addScript(TPL_JS.'ajaxupload.js');
        $this->load->model('service/company');
        $this->load->model('tool/image');

        $this->data['heading_title'] = $this->language->get('title_file');

        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }   

        $this->data['action'] = $this->url->link('account/company/file', '', 'SSL');
        $this->data['files'] = array();
        $company_id = $this->customer->isCompany();
        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            $this->model_service_company->editFile($company_id,$this->request->post); 
            $this->session->data['success']  = $this->language->get('text_success_file');
            $this->redirect($this->url->link('account/company/file'),'','SSL');
        }
        $results = $this->model_service_company->getCompanyFilesByCompanyId($company_id);
        foreach ($results as $item) {
            $this->data['files'][] = array(
                'file_id'   => $item['file_id'],
                'mode'      => $item['mode']=='identity' ? '身份证件' : '营业执照',
                //'sort'      => $item['sort'],
                'status'    => getCompanyFileStatus($item['status']).($item['status']==2 ? '<br><span title="'.$item['note'].'">'.truncate_string($item['note'],30).'</span>' : ''),
                'photo'     => file_exists($item['path']) ? $item['path'] : $this->model_tool_image->resize($item['path'],205,128),
                'date_added'=> date('Y-m-d H:i',strtotime($item['date_added']))
            );
        }
        $this->data['no_photo'] = $this->model_tool_image->resize('nopic.jpg', 205, 128);
        $this->template = $this->config->get('config_template') . '/template/account/company_file.tpl';
        
        $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/footer',
            'common/header' 
        );
                        
        $this->response->setOutput($this->render());    

    }

    public function certificate(){
        if (!$this->customer->isLogged()) {
            $this->session->data['redirect'] = $this->url->link('account/company', '', 'SSL');

            $this->redirect($this->url->link('account/login', '', 'SSL'));
        }

        $this->language->load('account/company');
        
        $this->document->setTitle($this->language->get('title_file'));
        $this->document->addScript(TPL_JS.'ajaxupload.js');
        $this->load->model('service/company');
        $this->load->model('tool/image');

        $this->data['heading_title'] = $this->language->get('title_file');

        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }   

        $this->data['action'] = $this->url->link('account/company/certificate', '', 'SSL');
        $this->data['certificates'] = array();
        $company_id = $this->customer->isCompany();
        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            $this->model_service_company->editCertificate($company_id,$this->request->post); 
            $this->session->data['success']  = $this->language->get('text_success_file');
            $this->redirect($this->url->link('account/company/certificate'),'','SSL');
        }
        $results = $this->model_service_company->getCompanyCertificatesByCompanyId($company_id);
        foreach ($results as $item) {
            $this->data['certificates'][] = array(
                'file_id'   => $item['file_id'],
                'title'     => $item['title'],
                'sort'      => $item['sort'],                
                'image'     => file_exists($item['image']) ? $item['image'] : $this->model_tool_image->resize('nopic.jpg',205,128),
                'date_added'=> date('Y-m-d H:i',strtotime($item['date_added']))
            );
        }
        $this->data['no_photo'] = $this->model_tool_image->resize('nopic.jpg', 205, 128);
        $this->template = $this->config->get('config_template') . '/template/account/company_certificate.tpl';
        
        $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/footer',
            'common/header' 
        );
                        
        $this->response->setOutput($this->render());    

    }
    public function custom1() {
        if (!$this->customer->isLogged()) {
            $this->session->data['redirect'] = $this->url->link('account/company', '', 'SSL');

            $this->redirect($this->url->link('account/login', '', 'SSL'));
        }

        $this->language->load('account/company');
        
        $this->document->setTitle($this->language->get('title_custom1'));
        $this->document->addScript(TPL_JS.'ajaxupload.js');
        $this->load->model('service/company');
        $this->load->model('tool/image');

        $this->data['heading_title'] = $this->language->get('title_custom1');

        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }   

        $this->data['action'] = $this->url->link('account/company/custom1', '', 'SSL');
        $company_id = $this->customer->isCompany();
        if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validateModule()) {
            $this->model_service_company->editModule($company_id,$this->request->post); 
            $this->session->data['success']  = $this->language->get('text_success_module');
            $this->redirect($this->url->link('account/company/custom1'),'','SSL');
        }
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }  

        if (isset($this->session->data['success'])) {
            $this->data['error_success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        } else {
            $this->data['error_success'] = '';
        } 
        $company_info = $this->model_service_company->getCompanyModule($company_id,1);
        if (isset($this->request->post['status'])) {
            $this->data['status'] = $this->request->post['status'];
        } else if (isset($company_info['status'])) {
            $this->data['status'] = $company_info['status'];
        } else {
            $this->data['status'] = 0;
        }

        if (isset($this->request->post['title'])) {
            $this->data['title'] = $this->request->post['title'];
        } else if (isset($company_info['title'])) {
            $this->data['title'] = $company_info['title'];
        } else {
            $this->data['title'] = '';
        }
        $this->data['thumb'] = $this->model_tool_image->resize('nopic.jpg',100,100);
        if (isset($this->request->post['image'])) {
            $this->data['image'] = $this->request->post['image'];
        } else if (isset($company_info['image']) && file_exists($company_info['image'])) {
            $this->data['image'] = $this->data['thumb'] = $company_info['image'];
        } else {
            $this->data['image'] = '';
        }
        $this->data['sort'] = 1;
        $this->data['no_photo'] = $this->model_tool_image->resize('nopic.jpg',100,100);
        $this->template = $this->config->get('config_template') . '/template/account/company_custom.tpl';
        
        $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/footer',
            'common/header' 
        );
                        
        $this->response->setOutput($this->render());    
    }
    public function custom2() {
        if (!$this->customer->isLogged()) {
            $this->session->data['redirect'] = $this->url->link('account/company', '', 'SSL');

            $this->redirect($this->url->link('account/login', '', 'SSL'));
        }

        $this->language->load('account/company');
        
        $this->document->setTitle($this->language->get('title_custom2'));
        $this->document->addScript(TPL_JS.'ajaxupload.js');
        $this->load->model('service/company');
        $this->load->model('tool/image');
        $this->data['heading_title'] = $this->language->get('title_custom2');

        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }   

        $this->data['action'] = $this->url->link('account/company/custom2', '', 'SSL');
        $company_id = $this->customer->isCompany();
        if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validateModule()) {
            $this->model_service_company->editModule($company_id,$this->request->post); 
            $this->session->data['success']  = $this->language->get('text_success_module');
            $this->redirect($this->url->link('account/company/custom2'),'','SSL');
        }
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }  

        if (isset($this->session->data['success'])) {
            $this->data['error_success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        } else {
            $this->data['error_success'] = '';
        } 
        $company_info = $this->model_service_company->getCompanyModule($company_id,2);

        if (isset($this->request->post['status'])) {
            $this->data['status'] = $this->request->post['status'];
        } else if (isset($company_info['status'])) {
            $this->data['status'] = $company_info['status'];
        } else {
            $this->data['status'] = 0;
        }

        if (isset($this->request->post['title'])) {
            $this->data['title'] = $this->request->post['title'];
        } else if (isset($company_info['title'])) {
            $this->data['title'] = $company_info['title'];
        } else {
            $this->data['title'] = '';
        }
        $this->data['thumb'] = $this->model_tool_image->resize('nopic.jpg',205,128);
        if (isset($this->request->post['image'])) {
            $this->data['image'] = $this->request->post['image'];
        } else if (isset($company_info['image']) && file_exists($company_info['image'])) {
            $this->data['image'] = $this->data['thumb'] = $company_info['image'];
        } else {
            $this->data['image'] = '';
        }
        $this->data['sort'] = 2;
        $this->data['no_photo'] = $this->model_tool_image->resize('nopic.jpg',100,100);
        $this->template = $this->config->get('config_template') . '/template/account/company_custom.tpl';
        
        $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/footer',
            'common/header' 
        );
                        
        $this->response->setOutput($this->render());    
    }  

    public function cases() {
        if (!$this->customer->isLogged()) {
            $this->session->data['redirect'] = $this->url->link('account/company', '', 'SSL');

            $this->redirect($this->url->link('account/login', '', 'SSL'));
        }

        $this->language->load('account/company');
        
        $this->document->setTitle($this->language->get('title_cases'));
        $this->document->addScript(TPL_JS.'ajaxupload.js');
        $this->load->model('service/company');
        $this->load->model('tool/image');
        
        $this->data['heading_title'] = $this->language->get('title_cases');

        $this->data['text_no_results'] = $this->language->get('text_no_results');
        $this->data['action'] = $this->url->link('account/company/cases', '', 'SSL');
        $this->data['cases'] = array();
        $company_id = $this->customer->isCompany();
        if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validateCase()) {
            $this->model_service_company->editCase($company_id,$this->request->post); 
            $this->session->data['success']  = $this->language->get('text_success_case');
            $this->redirect($this->url->link('account/company/cases'),'','SSL');
        }
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }  

        if (isset($this->session->data['success'])) {
            $this->data['error_success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        } else {
            $this->data['error_success'] = '';
        } 
        $results = $this->model_service_company->getCompanyCasesByCompanyId($company_id);
        foreach ($results as $item) {
            $this->data['cases'][] = array(
                'case_id' => $item['case_id'],
                'title'      => $item['title'],
                'sort'      => $item['sort'],
                'photo'     => file_exists($item['photo']) ? $item['photo'] : $this->model_tool_image->resize('nopic.jpg',150,150)
            );
        }
        $this->data['no_photo'] = $this->model_tool_image->resize('nopic.jpg', 205, 128);
        $this->template = $this->config->get('config_template') . '/template/account/company_case.tpl';
        
        $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/footer',
            'common/header' 
        );
                        
        $this->response->setOutput($this->render());    
    }  

    public function member() {
        if (!$this->customer->isLogged()) {
            $this->session->data['redirect'] = $this->url->link('account/company', '', 'SSL');

            $this->redirect($this->url->link('account/login', '', 'SSL'));
        }

        $this->language->load('account/company');
        
        $this->document->setTitle($this->language->get('title_member'));
        $this->document->addScript(TPL_JS.'ajaxupload.js');
        $this->load->model('service/company');
        $this->load->model('tool/image');
        
        $this->data['heading_title'] = $this->language->get('title_member');

        $this->data['text_no_results'] = $this->language->get('text_no_results');

        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }   

        $this->data['action'] = $this->url->link('account/company/member', '', 'SSL');

        $this->data['members'] = array();
        $company_id = $this->customer->isCompany();
        if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validateMember()) {
            $this->model_service_company->editMember($company_id,$this->request->post); 
            $this->session->data['success']  = $this->language->get('text_success_member');
            $this->redirect($this->url->link('account/company/member'),'','SSL');
        }
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }  

        if (isset($this->session->data['success'])) {
            $this->data['error_success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        } else {
            $this->data['error_success'] = '';
        } 
        $results = $this->model_service_company->getCompanyMembersByCompanyId($company_id);
        foreach ($results as $item) {
            $this->data['members'][] = array(
                'member_id' => $item['member_id'],
                'name'      => $item['name'],
                'position'  => $item['position'],
                'sort'      => $item['sort'],
                'avatar'    => file_exists($item['avatar']) ? $item['avatar'] : $this->model_tool_image->resize('nopic.jpg',150,150)
            );
        }
        $this->data['no_photo'] = $this->model_tool_image->resize('nopic.jpg', 205, 128);
        $this->template = $this->config->get('config_template') . '/template/account/company_member.tpl';
        
        $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/footer',
            'common/header' 
        );
                        
        $this->response->setOutput($this->render());    
    }
	protected function validateCompany() {
        $this->load->model('account/customer');
        $this->load->language('account/company');
        if ((utf8_strlen($this->request->post['title']) < 1) || (utf8_strlen($this->request->post['title']) > 32)) {
            $this->error['title'] = $this->language->get('error_title');
        }
		if ((utf8_strlen($this->request->post['corporation']) < 1) || (utf8_strlen($this->request->post['corporation']) > 32)) {
			$this->error['corporation'] = $this->language->get('error_corporation');
		}
        if(isset($this->request->post['email'])){
    		if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
    			$this->error['email'] = $this->language->get('error_email');
    		}else if (($this->customer->getEmail() != $this->request->post['email']) && $this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
                $this->error['email'] = $this->language->get('error_exists');
            }
        }

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

    public function validateDescription(){
        if ((utf8_strlen($this->request->post['description']) < 1) || (utf8_strlen($this->request->post['description']) > 512)) {
            $this->error['description'] = $this->language->get('error_description');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    protected function validateModule(){
        if(isset($this->request->post['status']) && $this->request->post['status']){

            if ((utf8_strlen($this->request->post['title']) < 1) || (utf8_strlen($this->request->post['title']) > 32)) {
                $this->error['title'] = $this->language->get('error_module_title');
            }
            if ((utf8_strlen($this->request->post['title']) < 1) || (utf8_strlen($this->request->post['title']) > 32)) {
                $this->error['title'] = $this->language->get('error_module_title');
            }
        }

        if (!isset($this->request->post['sort']) ) {
            $this->error['sort'] = $this->language->get('error_module_sort');
        }
        
        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    protected function validateCase(){
        if ((utf8_strlen($this->request->post['title']) < 1) || (utf8_strlen($this->request->post['title']) > 32)) {
            $this->error['title'] = $this->language->get('error_case_title');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    protected function validateMember(){
        if ((utf8_strlen($this->request->post['name']) < 1) || (utf8_strlen($this->request->post['name']) > 32)) {
            $this->error['name'] = $this->language->get('error_case_name');
        }

        if ((utf8_strlen($this->request->post['position']) < 1) || (utf8_strlen($this->request->post['position']) > 32)) {
            $this->error['position'] = $this->language->get('error_case_position');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

	private function area_js(){
        $file = TPL_JS.'area.js';
        if(!file_exists($file)){
            $this->load->model('localisation/area');
            $areas = $this->model_localisation_area->getAreas();
            $area_rows_group_by_pid = $this->array_group($areas, 'pid');

            $address = array();
            foreach ($area_rows_group_by_pid as $pid => $item) {
                if ($pid == 0) {
                    
                    $item = array_filter($item, function($item){
                        return $item['pid'] == 0;
                    });
                }
                $address['name'.$pid] = array_keys($this->array_group($item, 'name'));
                $address['code'.$pid] = array_keys($this->array_group($item, 'area_id'));
            }
            file_put_contents($file, 'var area = ' . json_encode_ex($address) . ';');
            
        }
        return $file;
    } 

    private function array_group($array, $key, $limit = false){
        if (empty ($array) || !is_array($array)){
            return $array;
        }

        $_result = array ();
        foreach ($array as $item) {
            if ((isset($item[$key]))) {
                $_result[(string)$item[$key]][] = $item;
            } else {
                $_result[count($_result)][] = $item;
            }
        }
        if (!$limit) {
            return $_result;
        }

        $result = array ();
        foreach ($_result as $k => $item) {
            $result[$k] = $item[0];
        }
        return $result;
    }

    public function ajax_data(){
        $this->load->model('service/company');
        $this->load->language('account/company');
        if(isset($this->request->get['action'])){
            $action = strtolower(trim($this->request->get['action']));
        }else if(isset($this->request->post['action'])){
            $action = strtolower(trim($this->request->post['action']));
        }else{
            $action = 'get';
        }
        $json = array('status'=>0,'msg'=>$this->language->get('text_exception'));
        switch ($action) {
            case 'getcase':
                $case_id = isset($this->request->get['case_id']) ? (int)$this->request->get['case_id'] : 0;
                $data = $this->model_service_company->getCase($case_id);
                if($data){
                    $json = array('status'=>1,'info'=>$data);
                }
            break;
            case 'deletecase':
                $case_id = isset($this->request->get['case_id']) ? (int)$this->request->get['case_id'] : 0;
                if($this->model_service_company->deleteCase($case_id)){
                    $json = array('status'=>1,'msg'=>$this->language->get('text_success_delete'));
                }
            break;
            case 'getmember':
                $member_id = isset($this->request->get['member_id']) ? (int)$this->request->get['member_id'] : 0;
                $data = $this->model_service_company->getMember($member_id);
                if($data){
                    $json = array('status'=>1,'info'=>$data);
                }
            break;
            case 'deletemember':
                $member_id = isset($this->request->get['member_id']) ? (int)$this->request->get['member_id'] : 0;
                if($this->model_service_company->deleteMember($member_id)){
                    $json = array('status'=>1,'msg'=>$this->language->get('text_success_delete'));
                }
            break;
            case 'getfile':
                $file_id = isset($this->request->get['file_id']) ? (int)$this->request->get['file_id'] : 0;
                $data = $this->model_service_company->getFile($file_id);
                if($data){
                    $json = array('status'=>1,'info'=>$data);
                }
            break;
            case 'deletefile':
                $file_id = isset($this->request->get['file_id']) ? (int)$this->request->get['file_id'] : 0;
                if($this->model_service_company->deleteFile($file_id)){
                    $json = array('status'=>1,'msg'=>$this->language->get('text_success_delete'));
                }
            case 'getcertificate':
                $file_id = isset($this->request->get['file_id']) ? (int)$this->request->get['file_id'] : 0;
                $data = $this->model_service_company->getCertificate($file_id);
                if($data){
                    $json = array('status'=>1,'info'=>$data);
                }
            break;
            case 'deletecertificate':
                $file_id = isset($this->request->get['file_id']) ? (int)$this->request->get['file_id'] : 0;
                if($this->model_service_company->deleteCertificate($file_id)){
                    $json = array('status'=>1,'msg'=>$this->language->get('text_success_delete'));
                }
            break;
        }
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}
