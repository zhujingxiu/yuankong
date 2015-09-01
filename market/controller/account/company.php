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
        $this->load->model('service/company');
        $this->load->model('tool/image');
		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_your_details'] = $this->language->get('text_your_details');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}	

        $this->data['action'] = $this->url->link('account/company/index', '', 'SSL');
        $company_id = $this->customer->isCompany();
		if ($this->request->server['REQUEST_METHOD'] != 'POST') {
            $company_info = $this->model_service_company->getCompany($company_id);
		}

        if (isset($company_info['mobile_phone'])) {
            $this->data['mobile_phone'] = $company_info['mobile_phone'];
        } else {
            $this->data['mobile_phone'] = '';
        }

        if (isset($this->request->post['code'])) {
            $this->data['code'] = $this->request->post['code'];
        } else if (isset($company_info['code'])) {
            $this->data['code'] = $company_info['code'];
        } else {
            $this->data['code'] = '';
        }
        $this->data['logo_thumb'] = $this->data['avatar_thumb'] = '';
		if (isset($this->request->post['logo'])) {
            $this->data['logo'] = $this->request->post['logo'];
        } else if (isset($company_info['logo'])) {
            $this->data['logo'] = $company_info['logo'];
			$this->data['logo_thumb'] = $this->model_tool_image->resize($company_info['logo'],95,95);
		} else {
			$this->data['logo'] = $this->model_tool_image->resize('nopic.jpg',95,95);
		}

        if (isset($this->request->post['cover'])) {
            $this->data['cover'] = $this->request->post['cover'];
        } else if (isset($company_info['cover'])) {
            $this->data['cover'] = $company_info['cover'];
            $this->data['cover_thumb'] = $this->model_tool_image->resize($company_info['cover'],280,175);
        } else {
            $this->data['cover'] = $this->model_tool_image->resize('nopic.jpg',280,175);
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

        $this->data['groups'] = $this->model_service_company->getCompanyGroupsByCompanyId($company_id);
        $this->data['all_groups'] = $this->model_service_company->getCompanyGroups();
        $this->data['no_photo'] = $this->model_tool_image->resize('nopic.jpg',100,100);
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
        $this->load->model('service/company');
        
        $this->data['heading_title'] = $this->language->get('title_description');

        $this->data['text_your_details'] = $this->language->get('text_your_details');

        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }   

        $this->data['action'] = $this->url->link('account/company/description', '', 'SSL');

        $company_id = $this->customer->isCompany();
        if ($this->request->server['REQUEST_METHOD'] != 'POST') {
            $company_info = $this->model_service_company->getCompany($company_id);
        }

        if (isset($this->request->post['description'])) {
            $this->data['description'] = $this->request->post['description'];
        } else if (isset($company_info['description'])) {
            $this->data['description'] = $company_info['description'];
        } else {
            $this->data['description'] = '';
        }
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
        if ($this->request->server['REQUEST_METHOD'] != 'POST') {
            $results = $this->model_service_company->getCompanyFilesByCompanyId($company_id);
            foreach ($results as $item) {
                $this->data['files'][] = array(
                    'file_id'   => $item['file_id'],
                    'mode'      => $item['mode']=='identity' ? '法人身份证件' : '营业执照',
                    'sort'      => $item['sort'],
                    'status'    => $item['status'],
                    'photo'     => $this->model_tool_image->resize($item['path'],205,128),
                    'date_added'=> date('Y-m-d H:i',strtotime($item['date_added']))
                );
            }
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
        if ($this->request->server['REQUEST_METHOD'] != 'POST') {
            $company_info = $this->model_service_company->getCompanyModule($company_id,1);
        }

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

        if (isset($this->request->post['image'])) {
            $this->data['image'] = $this->request->post['image'];
        } else if (isset($company_info['image'])) {
            $this->data['image'] = $this->model_tool_image->resize($company_info['image'],205,128);
        } else {
            $this->data['image'] = $this->model_tool_image->resize('nopic.jpg',205,128);
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
        if ($this->request->server['REQUEST_METHOD'] != 'POST') {
            $company_info = $this->model_service_company->getCompanyModule($company_id,2);
            
        }
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

        if (isset($this->request->post['image'])) {
            $this->data['image'] = $this->request->post['image'];
        } else if (isset($company_info['image'])) {
            $this->data['image'] = $this->model_tool_image->resize($company_info['image'],205,128);
        } else {
            $this->data['image'] = $this->model_tool_image->resize('nopic.jpg',205,128);
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

        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }   

        $this->data['action'] = $this->url->link('account/company/cases', '', 'SSL');
        $this->data['cases'] = array();
        $company_id = $this->customer->isCompany();
        if ($this->request->server['REQUEST_METHOD'] != 'POST') {
            $results = $this->model_service_company->getCompanyCasesByCompanyId($company_id);
            foreach ($results as $item) {
                $this->data['cases'][] = array(
                    'module_id' => $item['module_id'],
                    'name'      => $item['name'],
                    'sort'      => $item['sort'],
                    'photo'     => $this->model_tool_image->resize($item['photo'],150,150)
                );
            }
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
        if ($this->request->server['REQUEST_METHOD'] != 'POST') {
            $results = $this->model_service_company->getCompanyMembersByCompanyId($company_id);
            foreach ($results as $item) {
                $this->data['members'][] = array(
                    'member_id' => $item['member_id'],
                    'name'      => $item['name'],
                    'position'  => $item['position'],
                    'sort'      => $item['sort'],
                    'avatar'    => $this->model_tool_image->resize($item['avatar'],150,150)
                );
            }
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
	protected function validateInfo() {
        $this->load->model('account/customer');
        $this->load->language('account/company');
		if ((utf8_strlen($this->request->post['fullname']) < 1) || (utf8_strlen($this->request->post['fullname']) > 32)) {
			$this->error['fullname'] = $this->language->get('error_fullname');
		}
        if(isset($this->request->post['email'])){
    		if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
    			$this->error['email'] = $this->language->get('error_email');
    		}
        }
		
		if (($this->customer->getEmail() != $this->request->post['email']) && $this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
			$this->error['warning'] = $this->language->get('error_exists');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

    protected function validatePassword(){
        if(!isset($this->request->post['password']) || !$this->model_account_customer->validatePassword($this->request->post['password'])){
            $this->error['password'] = $this->language->get('error_password');
        }
        if ((utf8_strlen($this->request->post['newpwd']) < 1) || (utf8_strlen($this->request->post['newpwd']) > 32)) {
            $this->error['newpwd'] = $this->language->get('error_newpwd');
        }else{
            if ($this->request->post['newpwd'] != $this->request->post['confirm']) {
                $this->error['confirm'] = $this->language->get('error_confirm');
            }
        }
        
        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    protected function validateAddress(){
        if ((utf8_strlen($this->request->post['fullname']) < 1) || (utf8_strlen($this->request->post['fullname']) > 32)) {
            $this->error['fullname'] = $this->language->get('error_fullname');
        }
        if ((utf8_strlen($this->request->post['telephone']) < 3) || !isMobile($this->request->post['telephone'])) {
            $this->error['telephone'] = $this->language->get('error_telephone');
        }
        if ((utf8_strlen($this->request->post['address']) < 1) || utf8_strlen($this->request->post['address']) > 64) {
            $this->error['address'] = $this->language->get('error_address');
        }
        if (!isset($this->request->post['area']) || !is_array($this->request->post['area']) || !current($this->request->post['area'])) {
            $this->error['area'] = $this->language->get('error_area');
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

}
