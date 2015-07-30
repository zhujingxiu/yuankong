<?php
class ControllerAccountEdit extends Controller {
	private $error = array();

	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/edit', '', 'SSL');

			$this->redirect($this->url->link('account/login', '', 'SSL'));
		}

		$this->language->load('account/edit');
		
		$this->document->setTitle($this->language->get('heading_title'));
        $this->document->addScript('market/view/theme/yuankong/javascript/click.js');
		$this->document->addScript(TPL_JS.'ajaxupload.js');
		$this->document->addScript($this->area_js());
        $this->load->model('account/customer');
		$this->load->model('account/address');

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
        	'text'      => $this->language->get('text_edit'),
			'href'      => $this->url->link('account/edit', '', 'SSL'),       	
        	'separator' => $this->language->get('text_separator')
      	);
		
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_your_details'] = $this->language->get('text_your_details');

		$this->data['entry_fullname'] = $this->language->get('entry_fullname');
		$this->data['entry_lastname'] = $this->language->get('entry_lastname');
		$this->data['entry_email'] = $this->language->get('entry_email');
		$this->data['entry_telephone'] = $this->language->get('entry_telephone');
		$this->data['entry_fax'] = $this->language->get('entry_fax');

		$this->data['button_continue'] = $this->language->get('button_continue');
		$this->data['button_back'] = $this->language->get('button_back');

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
		
		if (isset($this->error['email'])) {
			$this->data['error_email'] = $this->error['email'];
		} else {
			$this->data['error_email'] = '';
		}	

        $this->data['password_action'] = $this->url->link('account/edit/password', '', 'SSL');
        $this->data['address_action'] = $this->url->link('account/edit/address', '', 'SSL');
		$this->data['avatar_action'] = $this->url->link('account/edit/avatar', '', 'SSL');
        $this->data['info_action'] = $this->url->link('account/edit/info', '', 'SSL');

		if ($this->request->server['REQUEST_METHOD'] != 'POST') {
            $customer_info = $this->model_account_customer->getCustomer($this->customer->getId());
			
		}
		if (isset($customer_info['mobile_phone'])) {
			$this->data['mobile_phone'] = $customer_info['mobile_phone'];
		} else {
			$this->data['mobile_phone'] = '';
		}

		if (isset($this->request->post['fullname'])) {
			$this->data['fullname'] = $this->request->post['fullname'];
		} else if (isset($customer_info['fullname'])) {
			$this->data['fullname'] = $customer_info['fullname'];
		} else {
			$this->data['fullname'] = '';
		}

		if (isset($this->request->post['email'])) {
			$this->data['email'] = $this->request->post['email'];
		} else if (isset($customer_info['email'])) {
			$this->data['email'] = $customer_info['email'];
		} else {
			$this->data['email'] = '';
		}

		if (isset($this->request->post['telephone'])) {
			$this->data['telephone'] = $this->request->post['telephone'];
		} else if (isset($customer_info['telephone'])) {
			$this->data['telephone'] = $customer_info['telephone'];
		} else {
			$this->data['telephone'] = '';
		}

		if (isset($this->request->post['fax'])) {
			$this->data['fax'] = $this->request->post['fax'];
		} else if (isset($customer_info['fax'])) {
			$this->data['fax'] = $customer_info['fax'];
		} else {
			$this->data['fax'] = '';
		}

        if (isset($this->request->post['avatar'])) {
            $this->data['avatar'] = $this->request->post['avatar'];
        } else if (isset($customer_info['avatar'])) {
            $this->data['avatar'] = $customer_info['avatar'];
        } else {
            $this->data['avatar'] = TPL_IMG.'avatar/default.jpg';
        }
        $this->data['addresses'] = $this->model_account_address->getAddresses();

		$this->data['back'] = $this->url->link('account/account', '', 'SSL');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/edit.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/edit.tpl';
		} else {
			$this->template = 'default/template/account/edit.tpl';
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

    public function info(){
        $json = array('status'=>0,'msg'=>$this->language->get('text_exception'));
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateInfo()) {
            $this->model_account_customer->editCustomer($this->request->post);
            
            $this->session->data['success'] = $this->language->get('text_success_customer');
            $json = array('status'=>1,'msg'=>$this->language->get('text_success_customer'));
            
        }
        $this->response->setOutput(json_encode($json));
    }
    public function avatar(){
        $json = array('status'=>0,'msg'=>$this->language->get('text_exception'));
        if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
            $this->model_account_customer->editAvatar($this->request->post);
            
            $this->session->data['success'] = $this->language->get('text_success_avatar');

            $json = array('status'=>1,'msg'=>$this->language->get('text_success_avatar'));
        }
        $this->response->setOutput(json_encode($json));
    }    

    public function address(){
        $json = array('status'=>0,'msg'=>$this->language->get('text_exception'));
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateAddress()) {
            $this->model_account_customer->addAddress($this->request->post);
            
            $this->session->data['success'] = $this->language->get('text_success_address');

            $json = array('status'=>1,'msg'=>$this->language->get('text_success_address'));
        }
        $this->response->setOutput(json_encode($json));
    }    

    public function password(){
        $json = array('status'=>0,'msg'=>$this->language->get('text_exception'));
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validatePassword()) {
            $this->model_account_customer->editPassword($this->request->post);
            
            $this->session->data['success'] = $this->language->get('text_success_password');

            $json = array('status'=>1,'msg'=>$this->language->get('text_success_password'));
        }
        $this->response->setOutput(json_encode($json));
    }
	protected function validateInfo() {
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
        if ((utf8_strlen($this->request->post['telephone']) > 3) || !isMobile($this->request->post['telephone'])) {
            $this->error['telephone'] = $this->language->get('error_telephone');
        }
        if ((utf8_strlen($this->request->post['address']) > 3) || utf8_strlen($this->request->post['address']) > 64) {
            $this->error['address'] = $this->language->get('error_address');
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

    public function upload() {
        $this->language->load('product/product');
        
        $json = array();
        
        if (!empty($this->request->files['avatar']['name'])) {
            $filename = basename(preg_replace('/[^a-zA-Z0-9\.\-\s+]/', '', html_entity_decode($this->request->files['avatar']['name'], ENT_QUOTES, 'UTF-8')));
            
            if ((utf8_strlen($filename) < 3) || (utf8_strlen($filename) > 64)) {
                $json['error'] = $this->language->get('error_filename');
            }       

            // Allowed file extension types
            $allowed = array();
            
            $filetypes = explode("\n", $this->config->get('config_file_extension_allowed'));
            
            foreach ($filetypes as $filetype) {
                $allowed[] = trim($filetype);
            }
            
            if (!in_array(substr(strrchr($filename, '.'), 1), $allowed)) {
                $json['error'] = $this->language->get('error_filetype');
            }   
            
            // Allowed file mime types      
            $allowed = array();
            
            $filetypes = explode("\n", $this->config->get('config_file_mime_allowed'));
            
            foreach ($filetypes as $filetype) {
                $allowed[] = trim($filetype);
            }
                            
            if (!in_array($this->request->files['avatar']['type'], $allowed)) {
                $json['error'] = $this->language->get('error_filetype');
            }           
            if ($this->request->files['avatar']['error'] != UPLOAD_ERR_OK) {
                $json['error'] = $this->language->get('error_upload_' . $this->request->files['avatar']['error']);
            }
        } else {
            $json['error'] = $this->language->get('error_upload');
        }
        
        if (!$json && is_uploaded_file($this->request->files['avatar']['tmp_name']) && file_exists($this->request->files['avatar']['tmp_name'])) {
            $pathinfo = pathinfo($filename);
            $file = substr(md5(mt_rand()),rand(0,12),12).'.'.$pathinfo['extension'];
            
            // Hide the uploaded file name so people can not link to it directly.
            
            move_uploaded_file($this->request->files['avatar']['tmp_name'], DIR_IMAGE.'avatar/' . $file);
            $json['path'] = TPL_IMG.'avatar/' . $file;
            $json['filename'] = basename($filename);            
            $json['success'] = $this->language->get('text_upload');
        }   
        
        $this->response->setOutput(json_encode($json));     
    } 
}
