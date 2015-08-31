<?php
class ControllerAccountForgotten extends Controller {
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

        $this->data['home'] = $this->url->link('common/home');
		if ($this->customer->isLogged()) {
			$this->redirect($this->url->link('account/account', '', 'SSL'));
		}

		$this->language->load('account/forgotten');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('account/customer');
		$this->load->model('affiliate/affiliate');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_account_customer->editPassword($this->request->post['mobile_phone'], $this->request->post['password']);
			$this->model_affiliate_affiliate->editPasswordByMobilePhone($this->request->post['mobile_phone'], $this->request->post['password']);
 
			$this->session->data['success'] = $this->language->get('text_success');
	  
			$this->redirect($this->url->link('account/forgotten/success', '', 'SSL'));
		}

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_your_email'] = $this->language->get('text_your_email');
		$this->data['text_email'] = $this->language->get('text_email');

		$this->data['entry_mobile_phone'] = $this->language->get('entry_mobile_phone');
		$this->data['entry_captcha'] = $this->language->get('entry_captcha');

		$this->data['button_continue'] = $this->language->get('button_continue');
		$this->data['button_back'] = $this->language->get('button_back');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->request->post['mobile_phone'])) {
    		$this->data['mobile_phone'] = $this->request->post['mobile_phone'];
		} else {
			$this->data['mobile_phone'] = '';
		}
		
		$this->data['action'] = $this->url->link('account/forgotten', '', 'SSL');
 
		$this->data['back'] = $this->url->link('account/login', '', 'SSL');
		$this->data['captcha'] = $this->url->link('account/register/captcha','','ssl');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/forgotten.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/forgotten.tpl';
		} else {
			$this->template = 'default/template/account/forgotten.tpl';
		}
		
		$this->children = array(
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/top'	
		);
								
		$this->response->setOutput($this->render());		
	}

	public function success(){
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

        $this->data['home'] = $this->url->link('common/home');
		if ($this->customer->isLogged()) {
			$this->redirect($this->url->link('account/account', '', 'SSL'));
		}

		$this->language->load('account/forgotten');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_your_email'] = $this->language->get('text_your_email');
		$this->data['text_email'] = $this->language->get('text_email');

		$this->data['entry_mobile_phone'] = $this->language->get('entry_mobile_phone');
		$this->data['entry_captcha'] = $this->language->get('entry_captcha');

		$this->data['button_continue'] = $this->language->get('button_continue');

		$this->data['login'] = $this->url->link('account/login', '', 'SSL');
		
		$this->template = $this->config->get('config_template') . '/template/account/forgotten_success.tpl';
		
		$this->children = array(
			'common/content_top',
			'common/content_bottom',
			'common/footer',
			'common/top'	
		);
								
		$this->response->setOutput($this->render());
	}

	protected function validate() {
    	if ((utf8_strlen($this->request->post['password']) < 4) || (utf8_strlen($this->request->post['password']) > 20)) {
      		$this->error['password'] = $this->language->get('error_password');
    	}

    	if ($this->request->post['confirm'] != $this->request->post['password']) {
      		$this->error['confirm'] = $this->language->get('error_confirm');
    	}  

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	public function validatePhone(){
  		$used = 0;
  		$this->load->model('account/customer');
  		$customer = $this->model_account_customer->getCustomerByMobilePhone($this->request->post['mobile_phone']);
  		if($customer){
  			$used = 1;
  		}
  		$this->response->setOutput(json_encode(array('used'=>$used)));
  	}

  	public function validateCaptcha(){
  		$status = 0;
  		$captcha = isset($this->session->data['captcha']) ? $this->session->data['captcha'] : false;
  		$_captcha = isset($this->request->post['captcha']) ? $this->request->post['captcha'] : false;
  		if($captcha && $_captcha && $captcha==$_captcha ){
  			$status = 1;
  		}
  		$this->response->setOutput(json_encode(array('status'=>$status)));
  	}

  	public function validateSMS(){
  		$status = 0;
  		$sms = isset($this->request->post['sms']) ? $this->request->post['sms'] : false;
  		$mobile_phone = isset($this->request->post['mobile_phone']) ? $this->request->post['mobile_phone'] : false;
  		$this->load->model('account/customer');
  		$sms_log = $this->model_account_customer->getSMS($this->request->post['mobile_phone']);

  		if(!empty($sms_log['sms']) && ($sms_log['sms'] == $sms) && (time() < ($sms_log['time']+30*60))) {
  			$status = 1;
  		}
  		$this->response->setOutput(json_encode(array('status'=>$status)));
  	}

  	public function getSMS(){
  		$json = array();	
  		$this->load->language('account/forgotten');
		if ((utf8_strlen($this->request->post['mobile_phone']) < 3) || !isMobile($this->request->post['mobile_phone'])) {
      		$json['error']['mobile_phone'] = $this->language->get('error_mobile_phone');
    	}
    	
    	$this->load->model('account/customer');

    	$sms_log = $this->model_account_customer->getSMS($this->request->post['mobile_phone']);
    	if($sms_log){
    		if(!empty($sms_log['sms']) && time() < ($sms_log['time']+30*60) ){
    			$json['error']['sms'] = $this->language->get('error_sms_time');
    		}
    	}

    	if(!$json){
	  		
	        $sms_number = mt_rand(100000,999999);
	        $sms = new Sms();
	  		$pattern = "尊敬的用户，".$sms_number."是您本次的验证码，该验证码10分钟内有效。【消防e站】";
	  		$res = $sms->sendMsg($this->request->post['mobile_phone'],$pattern);
	  		$this->model_account_customer->delSMS($this->request->post['mobile_phone']);
	  		$this->model_account_customer->addSMS($this->request->post['mobile_phone'],$sms_number);
	  		$json['success'] = $this->language->get('text_send_success');
	  		
    	}
  		$this->response->setOutput(json_encode($json));
  	}

}