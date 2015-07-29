<?php 
class ControllerAffiliateRegister extends Controller {
	private $error = array();
	      
  	public function index() {
		if ($this->affiliate->isLogged()) {
	  		$this->redirect($this->url->link('affiliate/account', '', 'SSL'));
    	}

    	$this->language->load('affiliate/register');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('affiliate/affiliate');
		
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_affiliate_affiliate->addAffiliate($this->request->post);

			$this->affiliate->login($this->request->post['email'], $this->request->post['password']);

	  		$this->redirect($this->url->link('affiliate/account'));
    	} 

      	$this->data['breadcrumbs'] = array();

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home'),        	
        	'separator' => false
      	); 

      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_account'),
			'href'      => $this->url->link('affiliate/account', '', 'SSL'),      	
        	'separator' => $this->language->get('text_separator')
      	);
		
      	$this->data['breadcrumbs'][] = array(
        	'text'      => $this->language->get('text_register'),
			'href'      => $this->url->link('affiliate/register', '', 'SSL'),      	
        	'separator' => $this->language->get('text_separator')
      	);
		
    	$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_select'] = $this->language->get('text_select');
		$this->data['text_none'] = $this->language->get('text_none');
		$this->data['text_account_already'] = sprintf($this->language->get('text_account_already'), $this->url->link('affiliate/login', '', 'SSL'));
    	$this->data['text_signup'] = $this->language->get('text_signup');
		$this->data['text_your_details'] = $this->language->get('text_your_details');
    	$this->data['text_your_address'] = $this->language->get('text_your_address');
		$this->data['text_payment'] = $this->language->get('text_payment');
    	$this->data['text_your_password'] = $this->language->get('text_your_password');
		$this->data['text_cheque'] = $this->language->get('text_cheque');
		$this->data['text_paypal'] = $this->language->get('text_paypal');
		$this->data['text_bank'] = $this->language->get('text_bank');
				
    	$this->data['entry_firstname'] = $this->language->get('entry_firstname');
    	$this->data['entry_lastname'] = $this->language->get('entry_lastname');
    	$this->data['entry_email'] = $this->language->get('entry_email');
    	$this->data['entry_telephone'] = $this->language->get('entry_telephone');
    	$this->data['entry_fax'] = $this->language->get('entry_fax');
    	$this->data['entry_company'] = $this->language->get('entry_company');
		$this->data['entry_website'] = $this->language->get('entry_website');
    	$this->data['entry_address_1'] = $this->language->get('entry_address_1');
    	$this->data['entry_address_2'] = $this->language->get('entry_address_2');
    	$this->data['entry_postcode'] = $this->language->get('entry_postcode');
    	$this->data['entry_city'] = $this->language->get('entry_city');
    	$this->data['entry_country'] = $this->language->get('entry_country');
    	$this->data['entry_zone'] = $this->language->get('entry_zone');
		$this->data['entry_tax'] = $this->language->get('entry_tax');
		$this->data['entry_payment'] = $this->language->get('entry_payment');
		$this->data['entry_cheque'] = $this->language->get('entry_cheque');
		$this->data['entry_paypal'] = $this->language->get('entry_paypal');
		$this->data['entry_bank_name'] = $this->language->get('entry_bank_name');
		$this->data['entry_bank_branch_number'] = $this->language->get('entry_bank_branch_number');
		$this->data['entry_bank_swift_code'] = $this->language->get('entry_bank_swift_code');
		$this->data['entry_bank_account_name'] = $this->language->get('entry_bank_account_name');
		$this->data['entry_bank_account_number'] = $this->language->get('entry_bank_account_number');
    	$this->data['entry_password'] = $this->language->get('entry_password');
    	$this->data['entry_confirm'] = $this->language->get('entry_confirm');

		$this->data['button_continue'] = $this->language->get('button_continue');
    
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		if (isset($this->error['fullname'])) {
			$this->data['error_fullname'] = $this->error['fullname'];
		} else {
			$this->data['error_fullname'] = '';
		}	
		
		if (isset($this->error['company'])) {
			$this->data['error_company'] = $this->error['company'];
		} else {
			$this->data['error_company'] = '';
		}		
	
		if (isset($this->error['email'])) {
			$this->data['error_email'] = $this->error['email'];
		} else {
			$this->data['error_email'] = '';
		}
		
		if (isset($this->error['mobile_phone'])) {
			$this->data['error_mobile_phone'] = $this->error['mobile_phone'];
		} else {
			$this->data['error_mobile_phone'] = '';
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
		
  		if (isset($this->error['address'])) {
			$this->data['error_address'] = $this->error['address'];
		} else {
			$this->data['error_address'] = '';
		}
   		
							
    	$this->data['action'] = $this->url->link('affiliate/register', '', 'SSL');
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

		if (isset($this->request->post['mobile_phone'])) {
    		$this->data['mobile_phone'] = $this->request->post['mobile_phone'];
		} else {
			$this->data['mobile_phone'] = '';
		}
		
		if (isset($this->request->post['telephone'])) {
    		$this->data['telephone'] = $this->request->post['telephone'];
		} else {
			$this->data['telephone'] = '';
		}
		
		if (isset($this->request->post['fax'])) {
    		$this->data['fax'] = $this->request->post['fax'];
		} else {
			$this->data['fax'] = '';
		}
		
		if (isset($this->request->post['company'])) {
    		$this->data['company'] = $this->request->post['company'];
		} else {
			$this->data['company'] = '';
		}

		if (isset($this->request->post['website'])) {
    		$this->data['website'] = $this->request->post['website'];
		} else {
			$this->data['website'] = '';
		}
				
		if (isset($this->request->post['address'])) {
    		$this->data['address'] = $this->request->post['address'];
		} else {
			$this->data['address'] = '';
		}

		if (isset($this->request->post['postcode'])) {
    		$this->data['postcode'] = $this->request->post['postcode'];
		} else {
			$this->data['postcode'] = '';
		}		

		if (isset($this->request->post['tax'])) {
    		$this->data['tax'] = $this->request->post['tax'];
		} else {
			$this->data['tax'] = '';
		}
		
		if (isset($this->request->post['payment'])) {
    		$this->data['payment'] = $this->request->post['payment'];
		} else {
			$this->data['payment'] = 'cheque';
		}

		if (isset($this->request->post['cheque'])) {
    		$this->data['cheque'] = $this->request->post['cheque'];
		} else {
			$this->data['cheque'] = '';
		}

		if (isset($this->request->post['bank_name'])) {
    		$this->data['bank_name'] = $this->request->post['bank_name'];
		} else {
			$this->data['bank_name'] = '';
		}

		if (isset($this->request->post['bank_branch_number'])) {
    		$this->data['bank_branch_number'] = $this->request->post['bank_branch_number'];
		} else {
			$this->data['bank_branch_number'] = '';
		}

		if (isset($this->request->post['bank_swift_code'])) {
    		$this->data['bank_swift_code'] = $this->request->post['bank_swift_code'];
		} else {
			$this->data['bank_swift_code'] = '';
		}

		if (isset($this->request->post['bank_account_name'])) {
    		$this->data['bank_account_name'] = $this->request->post['bank_account_name'];
		} else {
			$this->data['bank_account_name'] = '';
		}
		
		if (isset($this->request->post['bank_account_number'])) {
    		$this->data['bank_account_number'] = $this->request->post['bank_account_number'];
		} else {
			$this->data['bank_account_number'] = '';
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

		if ($this->config->get('config_affiliate_id')) {
			$this->load->model('catalog/information');
			
			$information_info = $this->model_catalog_information->getInformation($this->config->get('config_affiliate_id'));
			
			if ($information_info) {
				$this->data['text_agree'] = sprintf($this->language->get('text_agree'), $this->url->link('information/information/info', 'information_id=' . $this->config->get('config_affiliate_id'), 'SSL'), $information_info['title'], $information_info['title']);
			} else {
				$this->data['text_agree'] = '';
			}
		} else {
			$this->data['text_agree'] = '';
		}
		
		if (isset($this->request->post['agree'])) {
      		$this->data['agree'] = $this->request->post['agree'];
		} else {
			$this->data['agree'] = false;
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/affiliate/register.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/affiliate/register.tpl';
		} else {
			$this->template = 'default/template/affiliate/register.tpl';
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

  	protected function validate() {
        if (empty($this->session->data['captcha']) || ($this->session->data['captcha'] != $this->request->post['captcha'])) {
            $this->error['error'] = $this->language->get('error_captcha');
        }
    	if ((utf8_strlen($this->request->post['company']) < 1) || (utf8_strlen($this->request->post['company']) > 32)) {
      		$this->error['company'] = $this->language->get('error_company');
    	}

    	if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
      		$this->error['email'] = $this->language->get('error_email');
    	}

    	if ($this->model_affiliate_affiliate->getTotalAffiliatesByEmail($this->request->post['email'])) {
      		$this->error['warning'] = $this->language->get('error_exists');
    	}
		
    	if ((utf8_strlen($this->request->post['mobile_phone']) < 3) || (utf8_strlen($this->request->post['mobile_phone']) > 32)) {
      		$this->error['mobile_phone'] = $this->language->get('error_mobile_phone');
    	}

    	if ((utf8_strlen($this->request->post['address']) < 3) || (utf8_strlen($this->request->post['address']) > 128)) {
      		$this->error['address'] = $this->language->get('error_address');
    	}

    	if ((utf8_strlen($this->request->post['password']) < 4) || (utf8_strlen($this->request->post['password']) > 20)) {
      		$this->error['password'] = $this->language->get('error_password');
    	}

    	if ($this->request->post['confirm'] != $this->request->post['password']) {
      		$this->error['confirm'] = $this->language->get('error_confirm');
    	}
		
		if ($this->config->get('config_affiliate_id')) {
			$this->load->model('catalog/information');
			
			$information_info = $this->model_catalog_information->getInformation($this->config->get('config_affiliate_id'));
			
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