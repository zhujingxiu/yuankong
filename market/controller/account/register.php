<?php 
class ControllerAccountRegister extends Controller {
	private $error = array();
	      
  	public function index() {
		if ($this->customer->isLogged()) {
	  		$this->redirect($this->url->link('account/account', '', 'SSL'));
    	}
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		$this->data['base'] = $server;
		$this->data['description'] = $this->document->getDescription();
		$this->data['keywords'] = $this->document->getKeywords();
		$this->data['links'] = $this->document->getLinks();	 
		$this->data['styles'] = $this->document->getStyles();
		$this->data['scripts'] = $this->document->getScripts();
		$this->data['lang'] = $this->language->get('code');
		$this->data['direction'] = $this->language->get('direction');
		$this->data['baidu_analytics'] = html_entity_decode($this->config->get('config_baidu_analytics'), ENT_QUOTES, 'UTF-8');
		$this->data['name'] = $this->config->get('config_name');
		
		if ($this->config->get('config_icon') && file_exists(DIR_IMAGE . $this->config->get('config_icon'))) {
			$this->data['icon'] = $server . TPL_IMG . $this->config->get('config_icon');
		} else {
			$this->data['icon'] = '';
		}
		
		if ($this->config->get('config_logo') && file_exists(DIR_IMAGE . $this->config->get('config_logo'))) {
			$this->data['logo'] = $server . TPL_IMG . $this->config->get('config_logo');
		} else {
			$this->data['logo'] = '';
		}

    	$this->language->load('account/register');
		$this->data['title'] = $this->language->get('title_register');
		$this->document->setTitle($this->language->get('heading_title'));
				
		$this->load->model('account/customer'); 
		$this->load->model('service/company'); 

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if(isset($this->request->post['corporation'])){
				$this->model_service_company->addCompany($this->request->post);
			}else{
				$this->model_account_customer->addCustomer($this->request->post);
			}
			

			$this->customer->phone_login($this->request->post['mobile_phone'], $this->request->post['password']);
			
			unset($this->session->data['guest']);
			
			// Default Shipping Address
			if ($this->config->get('config_tax_customer') == 'shipping') {
				
				$this->session->data['shipping_province_id'] = $this->request->post['province_id'];
				$this->session->data['shipping_postcode'] = $this->request->post['postcode'];				
			}
							  	  
	  		$this->redirect($this->url->link('account/account'));
    	}
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
        	'text'      => $this->language->get('text_register'),
			'href'      => $this->url->link('account/register', '', 'SSL'),      	
        	'separator' => $this->language->get('text_separator')
      	);
    	$this->data['heading_title'] = $this->language->get('heading_title');

    	$this->data['text_home'] = $this->language->get('text_home');

    	$this->data['home'] = $this->url->link('common/home');
		$this->data['logged'] = $this->customer->isLogged();

		
		$this->data['text_account_already'] = sprintf($this->language->get('text_account_already'), $this->url->link('account/login', '', 'SSL'));
		$this->data['text_regs_customer'] = $this->language->get('text_regs_customer');
    	$this->data['text_regs_company'] = $this->language->get('text_regs_company');
    	$this->data['text_company_name'] = $this->language->get('text_company_name');
    	$this->data['text_company_email'] = $this->language->get('text_company_email');
		$this->data['text_qr_code'] = $this->language->get('text_qr_code');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_select'] = $this->language->get('text_select');
		$this->data['text_none'] = $this->language->get('text_none');
						
    	$this->data['entry_mobile_phone'] = $this->language->get('entry_mobile_phone');
    	$this->data['entry_fullname'] = $this->language->get('entry_fullname');
    	$this->data['entry_email'] = $this->language->get('entry_email');
		$this->data['entry_captcha'] = $this->language->get('entry_captcha');
		$this->data['entry_input_sms'] = $this->language->get('entry_input_sms');
		$this->data['text_captcha_change'] = $this->language->get('text_captcha_change');		
		$this->data['text_get_sms'] = $this->language->get('text_get_sms');
		$this->data['entry_company_telephone'] = $this->language->get('entry_company_telephone');
		$this->data['entry_company_name'] = $this->language->get('entry_company_name');
		$this->data['entry_company_customer'] = $this->language->get('entry_company_customer');
		$this->data['entry_company_company'] = $this->language->get('entry_company_company');
		$this->data['entry_company_group'] = $this->language->get('entry_company_group');
		$this->data['entry_company_address'] = $this->language->get('entry_company_address');
    	$this->data['entry_password'] = $this->language->get('entry_password');
    	$this->data['entry_confirm'] = $this->language->get('entry_confirm');

		$this->data['button_continue'] = $this->language->get('button_continue');
		$this->data['button_register'] = $this->language->get('button_register');
    
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->error['mobile_phone'])) {
			$this->data['error_mobile_phone'] = $this->error['mobile_phone'];
		} else {
			$this->data['error_mobile_phone'] = '';
		}
	
		if (isset($this->error['captcha'])) {
			$this->data['error_captcha'] = $this->error['captcha'];
		} else {
			$this->data['error_captcha'] = '';
		}
		
		if (isset($this->error['password'])) {
			$this->data['error_password'] = $this->error['password'];
		} else {
			$this->data['error_password'] = '';
		}
		
 		if (isset($this->error['confirm'])) {
			$this->data['error_confirm'] = $this->error['confirm'];
		} else {
			$this->data['error_confirm'] = '';
		}
	
    	$this->data['action'] = $this->url->link('account/register', '', 'SSL');
		
		if (isset($this->request->post['mobile_phone'])) {
    		$this->data['mobile_phone'] = $this->request->post['mobile_phone'];
		} else {
			$this->data['mobile_phone'] = '';
		}

		if (isset($this->request->post['fullname'])) {
    		$this->data['fullname'] = $this->request->post['fullname'];
		} else {
			$this->data['fullname'] = '';
		}

		if (isset($this->request->post['email'])) {
    		$this->data['email'] = $this->request->post['email'];
		} else {
			$this->data['email'] = '';
		}
		

		$this->load->model('account/customer_group');
		
		$this->data['customer_groups'] = array();
		
		if (is_array($this->config->get('config_customer_group_display'))) {
			$customer_groups = $this->model_account_customer_group->getCustomerGroups();
			
			foreach ($customer_groups as $customer_group) {
				if (in_array($customer_group['customer_group_id'], $this->config->get('config_customer_group_display'))) {
					$this->data['customer_groups'][] = $customer_group;
				}
			}
		}
		
		if (isset($this->request->post['customer_group_id'])) {
    		$this->data['customer_group_id'] = $this->request->post['customer_group_id'];
		} else {
			$this->data['customer_group_id'] = $this->config->get('config_customer_group_id');
		}
		
		if (isset($this->request->post['password'])) {
    		$this->data['password'] = $this->request->post['password'];
		} else {
			$this->data['password'] = '';
		}
		
		if (isset($this->request->post['confirm'])) {
    		$this->data['confirm'] = $this->request->post['confirm'];
		} else {
			$this->data['confirm'] = '';
		}

        if (isset($this->request->post['captcha'])) {
            $this->data['captcha'] = $this->request->post['captcha'];
        } else {
            $this->data['captcha'] = '';
        }

		$this->data['text_agree'] = '';
		if ($this->config->get('config_account_id')) {
			$this->load->model('catalog/information');
			
			$information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));
			
			if ($information_info) {
				$this->data['text_agree'] = sprintf($this->language->get('text_agree'), $this->url->link('information/information', 'information_id=' . $this->config->get('config_account_id'), 'SSL'), $information_info['title'], $information_info['title']);
			} 
		} 
		
		if (isset($this->request->post['agree'])) {
      		$this->data['agree'] = $this->request->post['agree'];
		} else {
			$this->data['agree'] = false;
		}
		
		$this->data['company_groups'] = $this->model_service_company->getCompanyGroups();
		$this->data['captcha_link'] = $this->url->link('common/tool/captcha','','ssl');
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/register.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/register.tpl';
		} else {
			$this->template = 'default/template/account/register.tpl';
		}
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/top'	
		);
				
		$this->response->setOutput($this->render());	
  	}

  	protected function validate() {

  		if (empty($this->session->data['captcha']) || ($this->session->data['captcha'] != $this->request->post['captcha'])) {
			$this->error['captcha'] = $this->language->get('error_captcha');
		}
		if ((utf8_strlen($this->request->post['mobile_phone']) < 3) || !isMobile($this->request->post['mobile_phone'])) {
      		$this->error['mobile_phone'] = $this->language->get('error_mobile_phone');
    	}
    	if ($this->model_account_customer->getCustomerByMobilePhone($this->request->post['mobile_phone'])) {
      		$this->error['warning'] = $this->language->get('error_exists');
    	}
    	if ((utf8_strlen($this->request->post['password']) < 4) || (utf8_strlen($this->request->post['password']) > 20)) {
      		$this->error['password'] = $this->language->get('error_password');
    	}

        $sms_log = $this->model_account_customer->getSMS($this->request->post['mobile_phone']);
        if(empty($sms_log['sms']) || (time() > ($sms_log['time']+30*60)) || ($sms_log['sms'] != $this->request->post['sms'])) {
            $this->error['sms'] = $this->language->get('error_sms');
        }

    	if ($this->request->post['confirm'] != $this->request->post['password']) {
      		$this->error['confirm'] = $this->language->get('error_confirm');
    	}
		
		if ($this->config->get('config_account_id')) {
			$this->load->model('catalog/information');
			
			$information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));
			
			if ($information_info && !isset($this->request->post['agree'])) {
      			$this->error['warning'] = sprintf($this->language->get('error_agree'), $information_info['title']);
			}
		}

    	if (!$this->error) {
      		return true;
    	} else {
      		return false;
    	}
  	}

	
}