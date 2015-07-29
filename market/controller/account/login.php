<?php 
class ControllerAccountLogin extends Controller {
	private $error = array();
	
	public function index() {
		
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

        $this->data['home'] = $this->url->link('common/home');
        $this->data['logged'] = $this->customer->isLogged();

		$this->load->model('account/customer');
		if (!empty($this->request->get['token'])) {
			$this->customer->logout();
			$this->cart->clear();

			unset($this->session->data['wishlist']);
			unset($this->session->data['shipping_address_id']);
			unset($this->session->data['shipping_country_id']);
			unset($this->session->data['shipping_zone_id']);
			unset($this->session->data['shipping_postcode']);
			unset($this->session->data['shipping_method']);
			unset($this->session->data['shipping_methods']);
			unset($this->session->data['payment_method']);
			unset($this->session->data['payment_methods']);
			unset($this->session->data['comment']);
			unset($this->session->data['order_id']);
			unset($this->session->data['coupon']);
			unset($this->session->data['reward']);
			unset($this->session->data['voucher']);
			unset($this->session->data['vouchers']);
			
			$customer_info = $this->model_account_customer->getCustomerByToken($this->request->get['token']);
			
		 	if ($customer_info && $this->customer->login($customer_info['mobile_phone'], '', true)) {
				// Default Addresses
				$this->load->model('account/address');
					
				$address_info = $this->model_account_address->getAddress($this->customer->getAddressId());
										
				if ($address_info) {
					if ($this->config->get('config_tax_customer') == 'shipping') {
						$this->session->data['shipping_province_id'] = $address_info['province_id'];
						$this->session->data['shipping_postcode'] = $address_info['postcode'];	
					}
					
				} else {
					unset($this->session->data['shipping_province_id']);	
					unset($this->session->data['shipping_postcode']);
				}
									
				$this->redirect($this->url->link('account/account', '', 'SSL')); 
			}
		}		
		
		if ($this->customer->isLogged()) {  
      		$this->redirect($this->url->link('account/account', '', 'SSL'));
    	}
	
    	$this->language->load('account/login');

    	$this->data['title'] = $this->language->get('title_login');
								
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			unset($this->session->data['guest']);
			
			// Default Shipping Address
			$this->load->model('account/address');
				
			$address_info = $this->model_account_address->getAddress($this->customer->getAddressId());
									
			if ($address_info) {
				if ($this->config->get('config_tax_customer') == 'shipping') {
					$this->session->data['shipping_province_id'] = $address_info['province_id'];
					$this->session->data['shipping_postcode'] = $address_info['postcode'];	
				}

			} else {
				unset($this->session->data['shipping_province_id']);	
				unset($this->session->data['shipping_postcode']);
			}
							
			if (isset($this->request->post['redirect']) && (strpos($this->request->post['redirect'], $this->config->get('config_url')) !== false || strpos($this->request->post['redirect'], $this->config->get('config_ssl')) !== false)) {
				$this->redirect(str_replace('&amp;', '&', $this->request->post['redirect']));
			} else {
				$this->redirect($this->url->link('account/account', '', 'SSL')); 
			}
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
        	'text'      => $this->language->get('text_login'),
			'href'      => $this->url->link('account/login', '', 'SSL'),      	
        	'separator' => $this->language->get('text_separator')
      	);
				
    	$this->data['heading_title'] = $this->language->get('heading_title');

    	$this->data['text_new_customer'] = $this->language->get('text_new_customer');
    	$this->data['text_customer'] = $this->language->get('text_customer');
    	$this->data['text_register'] = $this->language->get('text_register');
    	$this->data['text_register_account'] = $this->language->get('text_register_account');
		$this->data['text_returning_customer'] = $this->language->get('text_returning_customer');
		$this->data['text_i_am_returning_customer'] = $this->language->get('text_i_am_returning_customer');
    	$this->data['text_forgotten'] = $this->language->get('text_forgotten');
    	$this->data['text_auto'] = $this->language->get('text_auto');

    	$this->data['entry_email'] = $this->language->get('entry_email');
    	$this->data['entry_mobile_phone'] = $this->language->get('entry_mobile_phone');
    	$this->data['entry_password'] = $this->language->get('entry_password');

    	$this->data['button_continue'] = $this->language->get('button_continue');
		$this->data['button_login'] = $this->language->get('button_login');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
		$this->data['action'] = $this->url->link('account/login', '', 'SSL');
		$this->data['register'] = $this->url->link('account/register', '', 'SSL');
		$this->data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');

		if (isset($this->request->post['redirect']) && (strpos($this->request->post['redirect'], $this->config->get('config_url')) !== false || strpos($this->request->post['redirect'], $this->config->get('config_ssl')) !== false)) {
			$this->data['redirect'] = $this->request->post['redirect'];
		} elseif (isset($this->session->data['redirect'])) {
      		$this->data['redirect'] = $this->session->data['redirect'];
	  		
			unset($this->session->data['redirect']);		  	
    	} else {
			$this->data['redirect'] = '';
		}

		if (isset($this->session->data['success'])) {
    		$this->data['success'] = $this->session->data['success'];
    
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
		if (isset($this->request->post['email'])) {
			$this->data['email'] = $this->request->post['email'];
		} else {
			$this->data['email'] = '';
		}

		if (isset($this->request->post['mobile_phone'])) {
			$this->data['mobile_phone'] = $this->request->post['mobile_phone'];
		} else if(isset($_COOKIE['_remember_phone'])){
			$this->data['mobile_phone'] = $_COOKIE['_remember_phone'];
		}else{
            $this->data['mobile_phone'] = '';
        }

		if (isset($this->request->post['password'])) {
			$this->data['password'] = $this->request->post['password'];
		}else if(isset($_COOKIE['_remember_pwd'])){
            $this->data['password'] = $_COOKIE['_remember_pwd'];
        }else {
			$this->data['password'] = '';
		}

        $oauth_html = '';
        
        $oauth_lists = array();
        
        if ($this->config->get('oauth')) {
            foreach ($this->config->get('oauth') as $key => $val) {
                if ($val['status']) {           
                    $oauth_lists[$val['sort']] = array(
                        'tag'      => $key,
                        'status'   => $val['status'],
                        'href'     => $this->url->link('account/oauth/bind', 'tag='.$key, 'SSL')
                    );
                }
            }
                
            ksort($oauth_lists);
        }
        
        if ($oauth_lists) {
            $this->language->load('account/oauth');
            
            $oauth_html .= '<p class="f_s c8">'.$this->language->get('text_login').'</p>';
            $oauth_html .= '<p class="mt5">';
            foreach ($oauth_lists as $item) {
                $oauth_html .= '<a class="pr15" href="' . $item['href'] . '" >' ;
                $oauth_html .=  $item['tag'] ;
                $oauth_html .= '</a>';
            }
            $oauth_html .= '</p>';
        }
        
        if ($this->customer->isLogged()) {
            $oauth_html = '<div class="oauth_login">';
            $oauth_html .= $this->data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', 'SSL'), $this->customer->getFirstName(), $this->url->link('account/logout', '', 'SSL'));
            $oauth_html .= '</div>';
        }
        $this->data['oauth_html'] = $oauth_html;
				
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/login.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/login.tpl';
		} else {
			$this->template = 'default/template/account/login.tpl';
		}
		
		$this->children = array(
			'common/footer'
		);
						
		$this->response->setOutput($this->render());
  	}
  
  	protected function validate() {

    	if (!$this->customer->phone_login($this->request->post['mobile_phone'], $this->request->post['password'],false,(!empty($this->request->post['remember'])))) {
      		$this->error['warning'] = $this->language->get('error_phone_login');
    	}
	
		$customer_info = $this->model_account_customer->getCustomerByMobilePhone($this->request->post['mobile_phone']);
		
    	if ($customer_info && !$customer_info['approved']) {
      		//$this->error['warning'] = $this->language->get('error_approved');
    	}		
		
    	if (!$this->error) {
      		return true;
    	} else {
      		return false;
    	}  	
  	}
}