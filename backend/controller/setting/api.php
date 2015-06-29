<?php
class ControllerSettingApi extends Controller {
	private $error = array();
 
	public function index() {
		$this->language->load('setting/api'); 

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('api', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('setting/api', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_select'] = $this->language->get('text_select');
		$this->data['text_none'] = $this->language->get('text_none');
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_items'] = $this->language->get('text_items');
		$this->data['entry_debug'] = $this->language->get('entry_debug');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

		$this->data['tab_qq'] = $this->language->get('tab_qq');
		$this->data['tab_weibo'] = $this->language->get('tab_weibo');
		$this->data['tab_alipay'] = $this->language->get('tab_alipay');

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		
 		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = '';
		}
		
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('setting/setting', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
		
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		$this->data['action'] = $this->url->link('setting/api', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('setting/setting', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['token'] = $this->session->data['token'];

		//qq
		if (isset($this->request->post['api_qq_scope'])) {
			$this->data['api_qq_scope'] = $this->request->post['api_qq_scope'];
		} elseif ($this->config->get('api_qq_scope')) {
			$this->data['api_qq_scope'] = $this->config->get('api_qq_scope');	
		} else {
			$this->data['api_qq_scope'] = array();			
		}

		if (isset($this->request->post['api_qq_appid'])) {
			$this->data['api_qq_appid'] = $this->request->post['api_qq_appid'];
		} elseif ($this->config->get('api_qq_appid')) {
			$this->data['api_qq_appid'] = $this->config->get('api_qq_appid');			
		} else {
			$this->data['api_qq_appid'] = '';
		}
									
		if (isset($this->request->post['api_qq_appkey'])) {
			$this->data['api_qq_appkey'] = $this->request->post['api_qq_appkey'];
		} elseif ($this->config->get('api_qq_appkey')) {
			$this->data['api_qq_appkey'] = $this->config->get('api_qq_appkey');			
		} else {
			$this->data['api_qq_appkey'] = '';
		}	

		if (isset($this->request->post['api_qq_callback'])) {
			$this->data['api_qq_callback'] = $this->request->post['api_qq_callback'];
		} elseif ($this->config->get('api_qq_callback')) {
			$this->data['api_qq_callback'] = $this->config->get('api_qq_callback');			
		} else {
			$this->data['api_qq_callback'] = '';
		}
		
		if (isset($this->request->post['api_qq_debug'])) {
			$this->data['api_qq_debug'] = $this->request->post['api_qq_debug'];
		} elseif ($this->config->has('api_qq_debug')) {
			$this->data['api_qq_debug'] = $this->config->get('api_qq_debug');		
		} else {
			$this->data['api_qq_debug'] = 0;
		}

		$this->data['qq_scope'] = array(
			"get_user_info",
			"add_share",
			"list_album",
			"add_album",
			"upload_pic",
			"add_topic",
			"add_one_blog",
			"add_weibo",
			"check_page_fans",
			"add_t",
			"add_pic_t",
			"del_t",
			"get_repost_list",
			"get_info",
			"get_other_info",
			"get_fanslist",
			"get_idolist",
			"add_idol",
			"del_idol",
			"get_tenpay_addr"
		);
		//weibo
		if (isset($this->request->post['api_weibo_scope'])) {
			$this->data['api_weibo_scope'] = $this->request->post['api_weibo_scope'];
		} elseif ($this->config->get('api_weibo_scope')) {
			$this->data['api_weibo_scope'] = $this->config->get('api_weibo_scope');	
		} else {
			$this->data['api_weibo_scope'] = array();			
		}

		if (isset($this->request->post['api_weibo_appid'])) {
			$this->data['api_weibo_appid'] = $this->request->post['api_weibo_appid'];
		} elseif ($this->config->get('api_weibo_appid')) {
			$this->data['api_weibo_appid'] = $this->config->get('api_weibo_appid');			
		} else {
			$this->data['api_weibo_appid'] = '';
		}
									
		if (isset($this->request->post['api_weibo_appkey'])) {
			$this->data['api_weibo_appkey'] = $this->request->post['api_weibo_appkey'];
		} elseif ($this->config->get('api_weibo_appkey')) {
			$this->data['api_weibo_appkey'] = $this->config->get('api_weibo_appkey');			
		} else {
			$this->data['api_weibo_appkey'] = '';
		}	

		if (isset($this->request->post['api_weibo_callback'])) {
			$this->data['api_weibo_callback'] = $this->request->post['api_weibo_callback'];
		} elseif ($this->config->get('api_weibo_callback')) {
			$this->data['api_weibo_callback'] = $this->config->get('api_weibo_callback');			
		} else {
			$this->data['api_weibo_callback'] = '';
		}
		
		if (isset($this->request->post['api_weibo_debug'])) {
			$this->data['api_weibo_debug'] = $this->request->post['api_weibo_debug'];
		} elseif ($this->config->has('api_weibo_debug')) {
			$this->data['api_weibo_debug'] = $this->config->get('api_weibo_debug');		
		} else {
			$this->data['api_weibo_debug'] = 0;
		}

		$this->data['weibo_scope'] = array(
			"get_user_info",
			"add_share",
			"list_album",
			"add_album",
			"upload_pic",
			"add_topic",
			"add_one_blog",
			"add_weibo",
			"check_page_fans",
			"add_t",
			"add_pic_t",
			"del_t",
			"get_repost_list",
			"get_info",
			"get_other_info",
			"get_fanslist",
			"get_idolist",
			"add_idol",
			"del_idol",
			"get_tenpay_addr"
		);
		//alipay
		if (isset($this->request->post['api_alipay_scope'])) {
			$this->data['api_alipay_scope'] = $this->request->post['api_alipay_scope'];
		} elseif ($this->config->get('api_alipay_scope')) {
			$this->data['api_alipay_scope'] = $this->config->get('api_alipay_scope');	
		} else {
			$this->data['api_alipay_scope'] = array();			
		}

		if (isset($this->request->post['api_alipay_appid'])) {
			$this->data['api_alipay_appid'] = $this->request->post['api_alipay_appid'];
		} elseif ($this->config->get('api_alipay_appid')) {
			$this->data['api_alipay_appid'] = $this->config->get('api_alipay_appid');			
		} else {
			$this->data['api_alipay_appid'] = '';
		}
									
		if (isset($this->request->post['api_alipay_appkey'])) {
			$this->data['api_alipay_appkey'] = $this->request->post['api_alipay_appkey'];
		} elseif ($this->config->get('api_alipay_appkey')) {
			$this->data['api_alipay_appkey'] = $this->config->get('api_alipay_appkey');			
		} else {
			$this->data['api_alipay_appkey'] = '';
		}	

		if (isset($this->request->post['api_alipay_callback'])) {
			$this->data['api_alipay_callback'] = $this->request->post['api_alipay_callback'];
		} elseif ($this->config->get('api_alipay_callback')) {
			$this->data['api_alipay_callback'] = $this->config->get('api_alipay_callback');			
		} else {
			$this->data['api_alipay_callback'] = '';
		}
		
		if (isset($this->request->post['api_alipay_debug'])) {
			$this->data['api_alipay_debug'] = $this->request->post['api_alipay_debug'];
		} elseif ($this->config->has('api_alipay_debug')) {
			$this->data['api_alipay_debug'] = $this->config->get('api_alipay_debug');		
		} else {
			$this->data['api_alipay_debug'] = 0;
		}

		$this->data['alipay_scope'] = array(
			"get_user_info",
			"add_share",
			"list_album",
			"add_album",
			"upload_pic",
			"add_topic",
			"add_one_blog",
			"add_weibo",
			"check_page_fans",
			"add_t",
			"add_pic_t",
			"del_t",
			"get_repost_list",
			"get_info",
			"get_other_info",
			"get_fanslist",
			"get_idolist",
			"add_idol",
			"del_idol",
			"get_tenpay_addr"
		);
		$this->template = 'setting/api.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'setting/api')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

				
		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}
			
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
	

}