<?php
class ControllerAccountOauth extends Controller {
	private $error = array();

	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/oauth', '', 'SSL');

			$this->redirect($this->url->link('account/login', '', 'SSL'));
		}

		$this->language->load('account/oauth');

		$this->document->setTitle($this->language->get('heading_title'));

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->load->model('account/customer');

			$this->model_account_customer->editoauth($this->customer->getEmail(), $this->request->post['oauth']);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('account/account', '', 'SSL'));
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
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('account/oauth', '', 'SSL'),
			'separator' => $this->language->get('text_separator')
		);

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_welcome'] = $this->language->get('text_welcome');
		$this->data['text_confirm'] = $this->language->get('text_confirm');
		$this->data['button_continue'] = $this->language->get('button_continue');
		$this->data['button_back'] = $this->language->get('button_back');
		$this->data['button_bind'] = $this->language->get('button_bind');
		$this->data['button_remove'] = $this->language->get('button_remove');

		$this->data['action'] = $this->url->link('account/oauth/bind', '', 'SSL');
		$this->data['back'] = $this->url->link('account/account', '', 'SSL');
		
		$this->load->model('account/oauth');
		
		$oauth_lists = array();
		
		if ($this->config->get('oauth')) {
			foreach ($this->config->get('oauth') as $key => $val) {
				$binded = $this->model_account_oauth->getOauthByType($key);
				
				$oauth_lists[$val['sort']] = array(
					'tag'      => $key,
					'status'   => $val['status'],
					'binded'   => $binded,
					'name'     => $binded?$binded['name']:'',
					'face'     => $binded?$binded['face']:'',
				);
			}
				
			ksort($oauth_lists);
		}
				
		$this->data['oauth_lists'] = $oauth_lists;

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/oauth.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/oauth.tpl';
		} else {
			$this->template = 'default/template/account/oauth.tpl';
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
	
	// 绑定账户
	public function bind() {
		if (isset($this->request->get['tag'])) {
			$tag = $this->request->get['tag'];
		} else {
			$tag = '';
		}
		
		$tags = array(
			'qq',
			'weibo',
			'baidu',
			'alipay'
		);
		
		if (empty($tag) || !in_array($tag, $tags) || !$this->config->get('oauth')) {
			$this->redirect($this->url->link('common/home', '', 'SSL'));
		}
		
		$oauthInfo = $this->config->get('oauth');
		
		// 检查状态是否开启了
		if (!$oauthInfo[$tag]['status']) {
			$this->redirect($this->url->link('common/home', '', 'SSL'));
		}

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}
		
		$callback  = $server;
		$state = $tag.'|'.md5('getOauth'.time());
		
		$this->session->data['oauth']['state'] = $state;
		
		$url = $this->getUrl($tag, $oauthInfo[$tag]['client_id'], $callback, $state);
		
		$this->redirect($url);
	}
	
	// 取消绑定
	public function remove() {
		if (!$this->customer->isLogged()) {
			$this->redirect($this->url->link('account/login', '', 'SSL'));
		}
		
		if (!isset($this->request->get['tag'])) {
			$this->redirect($this->url->link('account/oauth', '', 'SSL'));
		}
		
		$this->load->model('account/oauth');
		
		$this->model_account_oauth->deleteOauth($this->request->get['tag']);
	}
	
	// 绑定返回页面
	public function callback() {
		if (!isset($this->request->get['code']) || !isset($this->request->get['state'])) {
			$this->redirect($this->url->link('common/home', '', 'SSL'));
		}
		
		if (!isset($this->session->data['oauth']) || $this->session->data['oauth']['state'] != $this->request->get['state']) {
			$this->redirect($this->url->link('common/home', '', 'SSL'));
		}

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}
		
		$tag = explode('|', $this->session->data['oauth']['state']);
		
		$callback  = $server;
		$tag       = $tag[0];
		$code      = $this->request->get['code'];
		$oauthInfo = $this->config->get('oauth');
		$appid     = $oauthInfo[$tag]['client_id'];
		$appkey    = $oauthInfo[$tag]['client_secret'];
		
		unset($this->session->data['oauth']);
		
		// 获取用户数据
		// array(openid, expires_in, access_token, name, face, email)
		$theRequest = $this->getOpenid($tag, $code, $appid, $appkey, $callback);
		
		//print_r($theRequest);
		$this->data['success'] = '0';
		$this->data['tag']     = $tag;
		$this->data['face']    = '';
		$this->data['name']    = '';
		$this->data['msg']     = '';
		
		if (isset($theRequest['error'])) {
			$this->data['msg']     = $theRequest['error_description'];
		}
		
		if (!isset($theRequest['error']) && !empty($theRequest)) {
			$this->load->model('account/oauth');
			$this->load->model('account/customer');
			
			// 查询OPENID是否已经存在
			$customer_oauth = $this->model_account_oauth->getOauthCustomerIdByOpenid($theRequest['openid'], $tag);
			
			// ------------------ 未登陆状态 ---------------
			if (!$this->customer->isLogged()) {
				if ($customer_oauth && !empty($customer_oauth['customer_id'])) {
					// 取出账户密码进行登陆
					$customer = $this->model_account_customer->getCustomer($customer_oauth['customer_id']);
					
					if ($customer) {
						$this->customer->login($customer['email'], '', true);
						$this->redirect($this->url->link('account/account', '', 'SSL'));
					}
				} else {
					$this->session->data['oauth'] = array();
					$this->session->data['oauth'] = $theRequest;
					$this->session->data['oauth']['tag'] = $tag;
					
					$this->redirect($this->url->link('account/oauth/login', '', 'SSL'));
				}
			}
			
			// ------------------ 已登陆状态 ---------------
			// OPENID 已经绑定过账户，返回错误信息
			if ($customer_oauth && !empty($customer_oauth['customer_id'])) {
				$this->data['success'] = '0';
				$this->data['tag']     = $tag;
				$this->data['face']    = $theRequest['face'];
				$this->data['name']    = $theRequest['name'];
				$this->data['msg']     = $this->language->get('text_error');
			}
			// 登陆状态下，OPENID 已记录，但未绑定有账户
			/*elseif ($customer_oauth && empty($customer_oauth['customer_id'])) {
				// 更新OPENID，绑定登陆的帐户
				$this->model_account_oauth->updateOauth();
				
				$this->data['success'] = '1';
				$this->data['tag']     = $tag;
				$this->data['face']    = $theRequest['face'];
				$this->data['name']    = $theRequest['name'];
				$this->data['msg']     = $this->language->get('text_success');
			}*/
			// OPENID 未存在，入库绑定帐户
			else {
				$data = array(
					'openid'       => $theRequest['openid'],
					'type'         => $tag,
					'face'         => $theRequest['face'],
					'name'         => $theRequest['name'],
					'token'        => $theRequest['access_token'],
					'expired'      => $theRequest['expires_in'],
				);
				
				// 记录OPENID，绑定登陆的帐户
				$this->model_account_oauth->addOauth($data);
				
				$this->data['success'] = '1';
				$this->data['tag']     = $tag;
				$this->data['face']    = $theRequest['face'];
				$this->data['name']    = $theRequest['name'];
				$this->data['msg']     = $this->language->get('text_success');
			}
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/oauth_callback.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/oauth_callback.tpl';
		} else {
			$this->template = 'default/template/account/oauth_callback.tpl';
		}

		$this->response->setOutput($this->render());
	}
	
	public function login() {
		if ($this->customer->isLogged()) {
			$this->redirect($this->url->link('account/account', '', 'SSL'));
		}
		
		if (empty($this->session->data['oauth'])) {
			$this->redirect($this->url->link('account/login', '', 'SSL'));
		}
		
		$info_array = $this->session->data['oauth'];
				
		$this->data['info'] = $info_array;
		
		$this->language->load('account/oauth');
		
		$this->document->setTitle($this->language->get('heading_login_title'));
		
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
        	'text'      => $this->language->get('heading_login_title'),
			'href'      => $this->url->link('account/oauth/login', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);
		
    	$this->data['heading_title'] = $this->language->get('heading_login_title');
		
		// Entry	
    	$this->data['entry_mobile_phone'] = $this->language->get('entry_mobile_phone');
    	$this->data['entry_firstname'] = $this->language->get('entry_firstname');
    	$this->data['entry_lastname'] = $this->language->get('entry_lastname');
    	$this->data['entry_email'] = $this->language->get('entry_email');
    	$this->data['entry_telephone'] = $this->language->get('entry_telephone');
    	$this->data['entry_fax'] = $this->language->get('entry_fax');
		$this->data['entry_company'] = $this->language->get('entry_company');
		$this->data['entry_customer_group'] = $this->language->get('entry_customer_group');
		$this->data['entry_company_id'] = $this->language->get('entry_company_id');
		$this->data['entry_tax_id'] = $this->language->get('entry_tax_id');
    	$this->data['entry_address_1'] = $this->language->get('entry_address_1');
    	$this->data['entry_address_2'] = $this->language->get('entry_address_2');
    	$this->data['entry_postcode'] = $this->language->get('entry_postcode');
    	$this->data['entry_city'] = $this->language->get('entry_city');
    	$this->data['entry_country'] = $this->language->get('entry_country');
    	$this->data['entry_zone'] = $this->language->get('entry_zone');
		$this->data['entry_newsletter'] = $this->language->get('entry_newsletter');
    	$this->data['entry_password'] = $this->language->get('entry_password');
    	$this->data['entry_confirm'] = $this->language->get('entry_confirm');
    	$this->data['entry_type'] = $this->language->get('entry_type');
		
		// Text
    	$this->data['text_user_hello'] = sprintf($this->language->get('text_user_hello'), $info_array['name']);
    	$this->data['text_user_tip'] = $this->language->get('text_user_tip');
    	$this->data['text_bind_info1'] = $this->language->get('text_bind_info1');
    	$this->data['text_bind_info2'] = $this->language->get('text_bind_info2');
    	$this->data['text_forgotten'] = $this->language->get('text_forgotten');
		$this->data['text_your_login'] = $this->language->get('text_your_login');
		$this->data['text_your_details'] = $this->language->get('text_your_details');
    	$this->data['text_your_address'] = $this->language->get('text_your_address');
    	$this->data['text_your_password'] = $this->language->get('text_your_password');
		$this->data['text_newsletter'] = $this->language->get('text_newsletter');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_select'] = $this->language->get('text_select');
		$this->data['text_none'] = $this->language->get('text_none');
		
		// Button
		$this->data['button_continue'] = $this->language->get('button_continue');
		
		// Link
		$this->data['forgotten'] = $this->url->link('account/forgotten', '', 'SSL');
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
		// 注册信息 and 登陆信息
		$this->data['action_register'] = $this->url->link('account/oauth/toregister', '', 'SSL');
		$this->data['action_login'] = $this->url->link('account/oauth/tologin', '', 'SSL');
		
		// 登陆信息
		if (isset($this->session->data['posts_login'])) {
			$posts_login = $this->session->data['posts_login'];
			unset($this->session->data['posts_login']);
		} else {
			$posts_login = array();
		}
		
		if (isset($this->session->data['error_login'])) {
			$error_login = $this->session->data['error_login'];
			unset($this->session->data['error_login']);
		} else {
			$error_login = '';
		}
		
		if ($error_login) {
			$this->data['error_login'] = $error_login;
		} else {
			$this->data['error_login'] = '';
		}
		
		if (isset($posts_login['email'])) {
			$this->data['login_email'] = $posts_login['email'];
		} else {
			$this->data['login_email'] = '';
		}

		if (isset($posts_login['password'])) {
			$this->data['login_password'] = $posts_login['password'];
		} else {
			$this->data['login_password'] = '';
		}
		
		// 注册信息
		if (isset($this->session->data['posts_register'])) {
			$posts_register = $this->session->data['posts_register'];
			unset($this->session->data['posts_register']);
		} else {
			$posts_register = array();
		}
		
		if (isset($this->session->data['error_register'])) {
			$error_register = $this->session->data['error_register'];
			unset($this->session->data['error_register']);
		} else {
			$error_register = array();
		}
		
		if (isset($error_register['warning'])) {
			$this->data['error_warning'] = $error_register['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($error_register['mobile_phone'])) {
			$this->data['error_mobile_phone'] = $error_register['mobile_phone'];
		} else {
			$this->data['error_mobile_phone'] = '';
		}
		
		if (isset($error_register['firstname'])) {
			$this->data['error_firstname'] = $error_register['firstname'];
		} else {
			$this->data['error_firstname'] = '';
		}	
		
		if (isset($error_register['lastname'])) {
			$this->data['error_lastname'] = $error_register['lastname'];
		} else {
			$this->data['error_lastname'] = '';
		}		
	
		if (isset($error_register['email'])) {
			$this->data['error_email'] = $error_register['email'];
		} else {
			$this->data['error_email'] = '';
		}
		
		if (isset($error_register['telephone'])) {
			$this->data['error_telephone'] = $error_register['telephone'];
		} else {
			$this->data['error_telephone'] = '';
		}
		
		if (isset($error_register['password'])) {
			$this->data['error_password'] = $error_register['password'];
		} else {
			$this->data['error_password'] = '';
		}
		
		if (isset($error_register['confirm'])) {
			$this->data['error_confirm'] = $error_register['confirm'];
		} else {
			$this->data['error_confirm'] = '';
		}
		
		if (isset($error_register['agree'])) {
			$this->data['error_agree'] = $error_register['agree'];
		} else {
			$this->data['error_agree'] = '';
		}
		
		if (isset($error_register['company_id'])) {
			$this->data['error_company_id'] = $error_register['company_id'];
		} else {
			$this->data['error_company_id'] = '';
		}
		
		if (isset($error_register['tax_id'])) {
			$this->data['error_tax_id'] = $error_register['tax_id'];
		} else {
			$this->data['error_tax_id'] = '';
		}
								
		if (isset($error_register['address_1'])) {
			$this->data['error_address_1'] = $error_register['address_1'];
		} else {
			$this->data['error_address_1'] = '';
		}
		
		if (isset($error_register['city'])) {
			$this->data['error_city'] = $error_register['city'];
		} else {
			$this->data['error_city'] = '';
		}
		
		if (isset($error_register['postcode'])) {
			$this->data['error_postcode'] = $error_register['postcode'];
		} else {
			$this->data['error_postcode'] = '';
		}

		if (isset($error_register['country'])) {
			$this->data['error_country'] = $error_register['country'];
		} else {
			$this->data['error_country'] = '';
		}

		if (isset($error_register['zone'])) {
			$this->data['error_zone'] = $error_register['zone'];
		} else {
			$this->data['error_zone'] = '';
		}
		
		$this->data['action'] = $this->url->link('account/register', '', 'SSL');

		if (isset($posts_register['nickname'])) {
			$this->data['nickname'] = $posts_register['nickname'];
		} else {
			$this->data['nickname'] = '';
		}

		if (isset($posts_register['firstname'])) {
			$this->data['firstname'] = $posts_register['firstname'];
		} else {
			$this->data['firstname'] = '';
		}

		if (isset($posts_register['lastname'])) {
			$this->data['lastname'] = $posts_register['lastname'];
		} else {
			$this->data['lastname'] = '';
		}
		
		if (isset($posts_register['email'])) {
			$this->data['email'] = $posts_register['email'];
		} else {
			$this->data['email'] = '';
		}
		
		if (isset($posts_register['telephone'])) {
			$this->data['telephone'] = $posts_register['telephone'];
		} else {
			$this->data['telephone'] = '';
		}
		
		if (isset($posts_register['fax'])) {
			$this->data['fax'] = $posts_register['fax'];
		} else {
			$this->data['fax'] = '';
		}
		
		if (isset($posts_register['company'])) {
			$this->data['company'] = $posts_register['company'];
		} else {
			$this->data['company'] = '';
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
		
		if (isset($posts_register['customer_group_id'])) {
			$this->data['customer_group_id'] = $posts_register['customer_group_id'];
		} else {
			$this->data['customer_group_id'] = $this->config->get('config_customer_group_id');
		}
		
		if (isset($posts_register['company_id'])) {
			$this->data['company_id'] = $posts_register['company_id'];
		} else {
			$this->data['company_id'] = '';
		}
		
		if (isset($posts_register['tax_id'])) {
			$this->data['tax_id'] = $posts_register['tax_id'];
		} else {
			$this->data['tax_id'] = '';
		}
						
		if (isset($posts_register['address_1'])) {
			$this->data['address_1'] = $posts_register['address_1'];
		} else {
			$this->data['address_1'] = '';
		}

		if (isset($posts_register['address_2'])) {
			$this->data['address_2'] = $posts_register['address_2'];
		} else {
			$this->data['address_2'] = '';
		}

		if (isset($posts_register['postcode'])) {
			$this->data['postcode'] = $posts_register['postcode'];
		} elseif (isset($this->session->data['shipping_postcode'])) {
			$this->data['postcode'] = $this->session->data['shipping_postcode'];		
		} else {
			$this->data['postcode'] = '';
		}
		
		if (isset($posts_register['city'])) {
			$this->data['city'] = $posts_register['city'];
		} else {
			$this->data['city'] = '';
		}

		if (isset($posts_register['country_id'])) {
			$this->data['country_id'] = $posts_register['country_id'];
		} elseif (isset($this->session->data['shipping_country_id'])) {
			$this->data['country_id'] = $this->session->data['shipping_country_id'];		
		} else {	
			$this->data['country_id'] = $this->config->get('config_country_id');
		}

		if (isset($posts_register['zone_id'])) {
			$this->data['zone_id'] = $posts_register['zone_id']; 	
		} elseif (isset($this->session->data['shipping_zone_id'])) {
			$this->data['zone_id'] = $this->session->data['shipping_zone_id'];			
		} else {
			$this->data['zone_id'] = '';
		}
		
		$this->load->model('localisation/country');
		
		$this->data['countries'] = $this->model_localisation_country->getCountries();
		
		if (isset($posts_register['password'])) {
			$this->data['password'] = $posts_register['password'];
		} else {
			$this->data['password'] = '';
		}
		
		if (isset($posts_register['confirm'])) {
			$this->data['confirm'] = $posts_register['confirm'];
		} else {
			$this->data['confirm'] = '';
		}
		
		if (isset($posts_register['newsletter'])) {
			$this->data['newsletter'] = $posts_register['newsletter'];
		} else {
			$this->data['newsletter'] = '';
		}	

		if ($this->config->get('config_account_id')) {
			$this->load->model('catalog/information');
			
			$information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));
			
			if ($information_info) {
				$this->data['text_agree'] = sprintf($this->language->get('text_agree'), $this->url->link('information/information/info', 'information_id=' . $this->config->get('config_account_id'), 'SSL'), $information_info['title'], $information_info['title']);
			} else {
				$this->data['text_agree'] = '';
			}
		} else {
			$this->data['text_agree'] = '';
		}
		
		if (isset($posts_register['agree'])) {
			$this->data['agree'] = $posts_register['agree'];
		} else {
			$this->data['agree'] = false;
		}
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/oauth_login.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/oauth_login.tpl';
		} else {
			$this->template = 'default/template/account/oauth_login.tpl';
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
	
  	public function tologin() {
		$this->load->model('account/customer');
    	$this->language->load('account/oauth');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate_login()) {
			unset($this->session->data['guest']);
			
			// Default Shipping Address
			$this->load->model('account/address');
				
			$address_info = $this->model_account_address->getAddress($this->customer->getAddressId());
									
			if ($address_info) {
				if ($this->config->get('config_tax_customer') == 'shipping') {
					$this->session->data['shipping_country_id'] = $address_info['country_id'];
					$this->session->data['shipping_zone_id'] = $address_info['zone_id'];
					$this->session->data['shipping_postcode'] = $address_info['postcode'];	
				}
				
				if ($this->config->get('config_tax_customer') == 'payment') {
					$this->session->data['payment_country_id'] = $address_info['country_id'];
					$this->session->data['payment_zone_id'] = $address_info['zone_id'];
				}
			} else {
				unset($this->session->data['shipping_country_id']);	
				unset($this->session->data['shipping_zone_id']);	
				unset($this->session->data['shipping_postcode']);
				unset($this->session->data['payment_country_id']);	
				unset($this->session->data['payment_zone_id']);	
			}
			
			$this->load->model('account/oauth');
			
			$data = array(
				'openid'       => $this->session->data['oauth']['openid'],
				'type'         => $this->session->data['oauth']['tag'],
				'face'         => $this->session->data['oauth']['face'],
				'name'         => $this->session->data['oauth']['name'],
				'token'        => $this->session->data['oauth']['access_token'],
				'expired'      => $this->session->data['oauth']['expires_in'],
			);
			
			$this->model_account_oauth->addOauth($data);
		
			unset($this->session->data['oauth']);
			
			$this->redirect($this->url->link('account/account', '', 'SSL'));
    	} else {
			$this->session->data['posts_login'] = $this->request->post;
			$this->session->data['error_login'] = $this->error['login'];
	  		$this->redirect($this->url->link('account/oauth/login', '', 'SSL'));
		}
	}
	
  	public function toregister() {
		$this->load->model('account/customer');
    	$this->language->load('account/oauth');
		
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate_register()) {
			$this->model_account_customer->addCustomer($this->request->post);

			$this->customer->login($this->request->post['email'], $this->request->post['password']);
			
			unset($this->session->data['guest']);
			
			// Default Shipping Address
			if ($this->config->get('config_tax_customer') == 'shipping') {
				$this->session->data['shipping_country_id'] = $this->request->post['country_id'];
				$this->session->data['shipping_zone_id'] = $this->request->post['zone_id'];
				$this->session->data['shipping_postcode'] = $this->request->post['postcode'];				
			}
			
			// Default Payment Address
			if ($this->config->get('config_tax_customer') == 'payment') {
				$this->session->data['payment_country_id'] = $this->request->post['country_id'];
				$this->session->data['payment_zone_id'] = $this->request->post['zone_id'];			
			}
			
			$this->load->model('account/oauth');
			
			$data = array(
				'openid'       => $this->session->data['oauth']['openid'],
				'type'         => $this->session->data['oauth']['tag'],
				'face'         => $this->session->data['oauth']['face'],
				'name'         => $this->session->data['oauth']['name'],
				'token'        => $this->session->data['oauth']['access_token'],
				'expired'      => $this->session->data['oauth']['expires_in'],
			);
			
			$this->model_account_oauth->addOauth($data);
		
			unset($this->session->data['oauth']);
							  	  
	  		$this->redirect($this->url->link('account/success'));
    	} else {
			$this->session->data['posts_register'] = $this->request->post;
			$this->session->data['error_register'] = $this->error['register'];
	  		$this->redirect($this->url->link('account/oauth/login', '', 'SSL'));
		}
	}
	
  	public function account_js() {
		$this->language->load('account/oauth');
		
		$html = '<a href="'.$this->url->link('account/oauth', '', 'SSL').'" class="list-group-item">'.$this->language->get('heading_title').'</a>';
		
		$html = '(function(){function l(){var html=\'' . $html . '\';document.write(html)};try{l()}catch(t){alert(t)}})();';
		
		$this->response->addHeader('Content-type: application/x-javascript');
		$this->response->setOutput($html);
	}
	
  	public function login_js() {
		$html = '';
		
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
			
			$html .= '<div class="oauth_login">';
			$html .= '<div class="oauth_title">'.$this->language->get('text_login').'</div>';
			$html .= '<ul>';
			foreach ($oauth_lists as $oauth_list) {
				$html .= '<li class="oauth_li_' . $oauth_list['tag'] . '"><a href="' . $oauth_list['href'] . '" title="' . $oauth_list['tag'] . '">' . $oauth_list['tag'] . '</a></li>';
			}
			$html .= '</ul>';
			$html .= '</div>';
		}
		
		if ($this->customer->isLogged()) {
			$html = '<div class="oauth_login">';
			$html .= $this->data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', 'SSL'), $this->customer->getFirstName(), $this->url->link('account/logout', '', 'SSL'));
			$html .= '</div>';
		}
		
		if (!$html) {
	  		$this->redirect($this->url->link('common/home', '', 'SSL'));
		}
		
		$html = '(function(){function l(){var html=\'' . $html . '\';if(typeof(c)!=\'undefined\'&&c){var css=\'<link rel="stylesheet" type="text/css" href="\'+c+\'" />\';html=css+html}document.write(html)};try{l()}catch(t){alert(t)}})();';
		
		$this->response->addHeader('Content-type: application/x-javascript');
		$this->response->setOutput($html);
	}

	private function getUrl($tag, $appid, $callback, $state) {
		switch ($tag) {

			case 'qq':
				$host  = 'https://graph.qq.com/oauth2.0/authorize?';
				
				$code = array();
				$code['response_type']   = 'code';
				$code['client_id']       = $appid;
				$code['state']           = $state;
				$code['redirect_uri']    = $callback;
				$code['scope']           = 'get_user_info';
				
				$url = $host . http_build_query($code);
				break;
			case 'weibo':
				$host  = 'https://api.weibo.com/oauth2/authorize?';
				
				$code = array();
				$code['response_type']   = 'code';
				$code['client_id']       = $appid;
				$code['state']           = $state;
				$code['redirect_uri']    = $callback;
				$code['scope']           = '';
				
				$url = $host . http_build_query($code);
				break;
			case 'aplipay':
				$alipay_config = array(
					'partner'		=> $appid,
					'key'			=> APP_SECRET,
					'sign_type'     => strtoupper('MD5'),
					'input_charset' => strtolower('utf-8'),
					'cacert'	    => getcwd().'\\cacert.pem',
					'transport'    	=> 'http'
				);
				$parameter = array(
					"service" 		=> "alipay.auth.authorize",
					"partner" 		=> $appid,
					"target_service"=> "user.auth.quick.login",
					"return_url"	=> $callback,
					"anti_phishing_key"	=> "",
					"exter_invoke_ip"	=> "",
					"_input_charset"	=> "utf-8"
				);
				
				$alipaySubmit = new AlipaySubmit($alipay_config);
				die($alipaySubmit->buildRequestForm($parameter,"get", "确认"));
				break;
			case 'baidu':
				$host  = 'http://openapi.baidu.com/oauth/2.0/authorize?';
				
				$code = array();
				$code['response_type']   = 'code';
				$code['client_id']       = $appid;
				$code['state']           = $state;
				$code['redirect_uri']    = $callback;
				$code['scope']           = 'basic';
				
				$url = $host . http_build_query($code);
				break;
			default:
				$url = '';
		}
		
		return $url;
	}
	
	private function getOpenid($tag, $code, $appid, $appkey, $callback) {
		switch ($tag) {
			case 'qq':
				$host = 'https://graph.qq.com/oauth2.0/token?';
		
				$param = array();			
				$param['client_id'] = $appid;
				$param['client_secret'] = $appkey;
				$param['grant_type'] = 'authorization_code';
				$param['code'] = $code;
				$param['redirect_uri'] = $callback;
			
				$url = $host . http_build_query($param);
				
				$response = $this->http($url, 'GET');
				
				if(strpos($response, "callback") !== false){
					$lpos = strpos($response, "(");
					$rpos = strrpos($response, ")");
					$response  = substr($response, $lpos + 1, $rpos - $lpos -1);
					$msg = json_decode($response, 1);
		
					if(isset($msg['error'])){
						$data = array(
							'error'               => $msg['error'],
							'error_description'   => $msg['error_description']
						);
					
						$this->log->write('QQ ERROR: '.$msg['error'].' - '.$msg['error_description']);
						
						break;
					}
				}
				
				$info          = explode('&', $response);
				$access_token  = str_replace('access_token=', '', $info[0]);
				$expires_in    = str_replace('expires_in=', '', $info[1]);
				$refresh_token = str_replace('refresh_token=', '', $info[2]);
				
				$host = 'https://graph.qq.com/oauth2.0/me?access_token='.$access_token;
				
				$response = $this->http($host, 'GET');
				
				if(strpos($response, "callback") !== false){
					$lpos = strpos($response, "(");
					$rpos = strrpos($response, ")");
					$response  = substr($response, $lpos + 1, $rpos - $lpos -1);
					$msg = json_decode($response, 1);
		
					if(isset($msg['error'])){
						$data = array(
							'error'               => $msg['error'],
							'error_description'   => $msg['error_description']
						);
					
						$this->log->write('QQ ERROR: '.$msg['error'].' - '.$msg['error_description']);
						
						break;
					}
				}
				
				$openid = $msg['openid'];
				
				$host = 'https://graph.qq.com/user/get_user_info?';
		
				$param = array();			
				$param['oauth_consumer_key'] = $appid;
				$param['openid'] = $openid;
				$param['access_token'] = $access_token;
			
				$url = $host . http_build_query($param);
				
				$user_info = $this->http($url, 'GET');
				
				if (isset($user_info['ret']) && $user_info['ret']) {
					$this->log->write('QQ ERROR: '.$user_info['ret'].' - '.$user_info['msg']);
					
					$data = array(
						'error'               => $user_info['ret'],
						'error_description'   => $user_info['msg']
					);
					break;
				}
				
				$data = array(
					'openid'          => $openid,
					'expires_in'      => $expires_in,
					'access_token'    => $access_token,
					'name'            => $user_info['nickname'],
					'face'            => $user_info['figureurl_2'],
					'email'           => ''
				);
				
				break;
			case 'weibo':
				$host = 'https://api.weibo.com/oauth2/access_token?';
		
				$param = array();			
				$param['client_id'] = $appid;
				$param['client_secret'] = $appkey;
				$param['grant_type'] = 'authorization_code';
				$param['code'] = $code;
				$param['redirect_uri'] = $callback;
			
				$url = $host . http_build_query($param);
				
				$info = $this->http($url, 'POST', http_build_query($param));
				
				if (isset($info['error'])) {
					$this->log->write('WEIBO ERROR: '.$info['error'].' - '.$info['error_description']);
					
					$data = array(
						'error'               => $info['error'],
						'error_description'   => $info['error_description']
					);
					break;
				}
				
				$access_token  = $info['access_token'];
				$expires_in    = $info['expires_in'];
				$remind_in     = $info['remind_in'];
				$uid           = $info['uid'];
				
				$host = 'https://api.weibo.com/2/users/show.json?';
				
				$param = array();			
				$param['access_token'] = $access_token;
				$param['uid'] = $uid;
			
				$url = $host . http_build_query($param);
				
				$user_info = $this->http($url, 'GET');
				
				if (isset($user_info['error_code'])) {
					$this->log->write('WEIBO ERROR: '.$user_info['error_code'].' - '.$user_info['error']);
					
					$data = array(
						'error'               => $user_info['error_code'],
						'error_description'   => $user_info['error']
					);
					break;
				}
			
				$data = array(
					'openid'          => $uid,
					'expires_in'      => $expires_in,
					'access_token'    => $access_token,
					'name'            => $user_info['name'],
					'face'            => $user_info['profile_image_url'],
					'email'           => ''
				);
				
				break;
			case 'alipay':

				$alipay_config['partner']		= $appid;
				$alipay_config['key']			= $appkey;
				$alipay_config['grant_type']	= 'authorization_code';
				$alipay_config['sign_type']    = strtoupper('MD5');
				$alipay_config['input_charset']= strtolower('utf-8');
				$alipay_config['cacert']    = getcwd().'\\cacert.pem';
				$alipay_config['transport']    = 'http';
			
				$alipayNotify = new AlipayNotify($alipay_config);
				$info = $alipayNotify->verifyReturn();
				
				if (isset($info['error'])) {
					$this->log->write('WEIBO ERROR: '.$info['error'].' - '.$info['error_description']);
					
					$data = array(
						'error'               => $info['error'],
						'error_description'   => $info['error_description']
					);
					break;
				}
				
				$access_token  = $info['access_token'];
				$expires_in    = $info['expires_in'];
				$remind_in     = $info['remind_in'];
				$uid           = $info['uid'];
				
				$host = 'https://api.weibo.com/2/users/show.json?';
				
				$param = array();			
				$param['access_token'] = $access_token;
				$param['uid'] = $uid;
			
				$url = $host . http_build_query($param);
				
				$user_info = $this->http($url, 'GET');
				
				if (isset($user_info['error_code'])) {
					$this->log->write('WEIBO ERROR: '.$user_info['error_code'].' - '.$user_info['error']);
					
					$data = array(
						'error'               => $user_info['error_code'],
						'error_description'   => $user_info['error']
					);
					break;
				}
			
				$data = array(
					'openid'          => $uid,
					'expires_in'      => $expires_in,
					'access_token'    => $info['access_token'],
					'name'            => $user_info['name'],
					'face'            => $user_info['profile_image_url'],
					'email'           => ''
				);
				
				break;				
			case 'baidu':
				$host = 'https://openapi.baidu.com/oauth/2.0/token?';
		
				$param = array();			
				$param['client_id'] = $appid;
				$param['client_secret'] = $appkey;
				$param['grant_type'] = 'authorization_code';
				$param['code'] = $code;
				$param['redirect_uri'] = $callback;
			
				$url = $host . http_build_query($param);
				
				$info = $this->http($url, 'POST', http_build_query($param));
				
				if (isset($info['error'])) {
					$this->log->write('BAIDU ERROR: '.$info['error'].' - '.$info['error_description']);
					
					$data = array(
						'error'               => $info['error'],
						'error_description'   => $info['error_description']
					);
					break;
				}
				
				$access_token  = $info['access_token'];
				$expires_in    = $info['expires_in'];
				$refresh_token = $info['refresh_token'];
				
				$host = 'https://openapi.baidu.com/rest/2.0/passport/users/getLoggedInUser?';
		
				$param = array();
				$param['format'] = 'json';
				$param['access_token'] = $access_token;
			
				$url = $host . http_build_query($param);
				
				$user_info = $this->http($url, 'POST', http_build_query($param));
				
				if (isset($user_info['error_code'])) {
					$this->log->write('BAIDU ERROR: '.$user_info['error_code'].' - '.$user_info['error_msg']);
					
					$data = array(
						'error'               => $user_info['error_code'],
						'error_description'   => $user_info['error_msg']
					);
					break;
				}
			
				$data = array(
					'openid'          => $user_info['uid'],
					'expires_in'      => $expires_in,
					'access_token'    => $access_token,
					'name'            => $user_info['uname'],
					'face'            => 'http://tb.himg.baidu.com/sys/portrait/item/'.$user_info['portrait'],
					'email'           => ''
				);
				
				break;
			default:
				$data = array();
		}
		
		return $data;
	}
	
  	protected function validate_login() {		
		if (!$this->error) {
			if (!$this->customer->login($this->request->post['email'], $this->request->post['password'])) {
				$this->error['login'] = $this->language->get('error_login');
			}
		
			$customer_info = $this->model_account_customer->getCustomerByEmail($this->request->post['email']);
			
			if ($customer_info && !$customer_info['approved']) {
				$this->error['login'] = $this->language->get('error_approved');
			}
		}
		
    	if (!$this->error) {
      		return true;
    	} else {
      		return false;
    	}  
	}

  	protected function validate_register() {		
		if (!$this->error) {
			if ((utf8_strlen($this->request->post['nickname']) < 1) || (utf8_strlen($this->request->post['nickname']) > 32)) {
				$this->error['register']['nickname'] = $this->language->get('error_nickname');
			}
			if ((utf8_strlen($this->request->post['firstname']) < 1) || (utf8_strlen($this->request->post['firstname']) > 32)) {
				$this->error['register']['firstname'] = $this->language->get('error_firstname');
			}
	
			if ((utf8_strlen($this->request->post['lastname']) < 1) || (utf8_strlen($this->request->post['lastname']) > 32)) {
				$this->error['register']['lastname'] = $this->language->get('error_lastname');
			}
	
			if ((utf8_strlen($this->request->post['email']) > 96) || !preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $this->request->post['email'])) {
				$this->error['register']['email'] = $this->language->get('error_email');
			}
	
			if ($this->model_account_customer->getTotalCustomersByEmail($this->request->post['email'])) {
				$this->error['register']['email'] = $this->language->get('error_exists');
			}
			
			if ((utf8_strlen($this->request->post['telephone']) < 3) || (utf8_strlen($this->request->post['telephone']) > 32)) {
				$this->error['register']['telephone'] = $this->language->get('error_telephone');
			}
			
			// Customer Group
			$this->load->model('account/customer_group');
			
			if (isset($this->request->post['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($this->request->post['customer_group_id'], $this->config->get('config_customer_group_display'))) {
				$customer_group_id = $this->request->post['customer_group_id'];
			} else {
				$customer_group_id = $this->config->get('config_customer_group_id');
			}
	
			$customer_group = $this->model_account_customer_group->getCustomerGroup($customer_group_id);
				
			if ($customer_group) {	
				// Company ID
				if ($customer_group['company_id_display'] && $customer_group['company_id_required'] && empty($this->request->post['company_id'])) {
					$this->error['register']['company_id'] = $this->language->get('error_company_id');
				}
				
				// Tax ID 
				if ($customer_group['tax_id_display'] && $customer_group['tax_id_required'] && empty($this->request->post['tax_id'])) {
					$this->error['register']['tax_id'] = $this->language->get('error_tax_id');
				}						
			}
			
			if ((utf8_strlen($this->request->post['address_1']) < 3) || (utf8_strlen($this->request->post['address_1']) > 128)) {
				$this->error['register']['address_1'] = $this->language->get('error_address_1');
			}
	
			if ((utf8_strlen($this->request->post['city']) < 2) || (utf8_strlen($this->request->post['city']) > 128)) {
				$this->error['register']['city'] = $this->language->get('error_city');
			}
	
			$this->load->model('localisation/country');
			
			$country_info = $this->model_localisation_country->getCountry($this->request->post['country_id']);
			
			if ($country_info) {
				if ($country_info['postcode_required'] && (utf8_strlen($this->request->post['postcode']) < 2) || (utf8_strlen($this->request->post['postcode']) > 10)) {
					$this->error['register']['postcode'] = $this->language->get('error_postcode');
				}
				
				// VAT Validation
				$this->load->helper('vat');
				
				if ($this->config->get('config_vat') && $this->request->post['tax_id'] && (vat_validation($country_info['iso_code_2'], $this->request->post['tax_id']) == 'invalid')) {
					$this->error['register']['tax_id'] = $this->language->get('error_vat');
				}
			}
	
			if ($this->request->post['country_id'] == '') {
				$this->error['register']['country'] = $this->language->get('error_country');
			}
			
			if (!isset($this->request->post['zone_id']) || $this->request->post['zone_id'] == '') {
				$this->error['register']['zone'] = $this->language->get('error_zone');
			}
	
			if ((utf8_strlen($this->request->post['password']) < 4) || (utf8_strlen($this->request->post['password']) > 20)) {
				$this->error['register']['password'] = $this->language->get('error_password');
			}
	
			if ($this->request->post['confirm'] != $this->request->post['password']) {
				$this->error['register']['confirm'] = $this->language->get('error_confirm');
			}
			
			if ($this->config->get('config_account_id')) {
				$this->load->model('catalog/information');
				
				$information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));
				
				if ($information_info && !isset($this->request->post['agree'])) {
					$this->error['register']['agree'] = sprintf($this->language->get('error_agree'), $information_info['title']);
				}
			}
		}
		
    	if (!$this->error) {
      		return true;
    	} else {
      		return false;
    	}
  	}
	
	/**
	 * Make an HTTP request 发送一个HTTP请求
	 *
	 * @return string API results   返回请求字符串数据
	 * @ignore
	 */
	private function http($url, $method = 'GET', $postfields = NULL, $headers = array(), $location = false) {
		$ci=curl_init();
		curl_setopt($ci, CURLOPT_SSL_VERIFYPEER, FALSE); 
		curl_setopt($ci, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ci, CURLOPT_CONNECTTIMEOUT, 30);
		curl_setopt($ci, CURLOPT_TIMEOUT, 30);
		if($method=='POST'){
			curl_setopt($ci, CURLOPT_POST, TRUE);
			if($postfields!='')curl_setopt($ci, CURLOPT_POSTFIELDS, $postfields);
		}
		//$headers[]='User-Agent: Oauth.PHP(65li.com)';
		curl_setopt($ci, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($ci, CURLOPT_URL, $url);
		
		if ($location) {
			curl_setopt($ci, CURLOPT_HEADER, 1);
		}
		
		$response=curl_exec($ci);
		curl_close($ci);
		
		if (!$this->is_not_json($response)) {
			return json_decode($response, 1);
		} else {
			return $response;
		}
	}
	
	private function is_not_json($str){  
		return is_null(json_decode($str));
	}
}