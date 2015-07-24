<?php 
class ControllerAccountAddress extends Controller {
	private $error = array();
	  
  	public function index() {
    	if (!$this->customer->isLogged()) {
	  		$this->session->data['redirect'] = $this->url->link('account/address', '', 'SSL');

	  		$this->redirect($this->url->link('account/login', '', 'SSL')); 
    	}
	
    	$this->language->load('account/address');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('account/address');
		
		$this->getList();
  	}

  	public function insert() {
    	if (!$this->customer->isLogged()) {
	  		$this->session->data['redirect'] = $this->url->link('account/address', '', 'SSL');

	  		$this->redirect($this->url->link('account/login', '', 'SSL')); 
    	} 

    	$this->language->load('account/address');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('account/address');
			
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_account_address->addAddress($this->request->post);
			
      		$this->session->data['success'] = $this->language->get('text_insert');

	  		$this->redirect($this->url->link('account/address', '', 'SSL'));
    	} 
	  	
		$this->getForm();
  	}

  	public function update() {
    	if (!$this->customer->isLogged()) {
	  		$this->session->data['redirect'] = $this->url->link('account/address', '', 'SSL');

	  		$this->redirect($this->url->link('account/login', '', 'SSL')); 
    	} 
		
    	$this->language->load('account/address');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('account/address');
		
    	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
       		$this->model_account_address->editAddress($this->request->get['address_id'], $this->request->post);
	  		
			// Default Shipping Address
			if (isset($this->session->data['shipping_address_id']) && ($this->request->get['address_id'] == $this->session->data['shipping_address_id'])) {
				$this->session->data['shipping_province_id'] = $this->request->post['province_id'];
				$this->session->data['shipping_postcode'] = $this->request->post['postcode'];
				
				unset($this->session->data['shipping_method']);	
				unset($this->session->data['shipping_methods']);
			}
			
			// Default Payment Address
			if (isset($this->session->data['payment_address_id']) && ($this->request->get['address_id'] == $this->session->data['payment_address_id'])) {
				$this->session->data['payment_province_id'] = $this->request->post['province_id'];
	  			
				unset($this->session->data['payment_method']);
				unset($this->session->data['payment_methods']);
			}
			
			$this->session->data['success'] = $this->language->get('text_update');
	  
	  		$this->redirect($this->url->link('account/address', '', 'SSL'));
    	} 
	  	
		$this->getForm();
  	}

  	public function delete() {
    	if (!$this->customer->isLogged()) {
	  		$this->session->data['redirect'] = $this->url->link('account/address', '', 'SSL');

	  		$this->redirect($this->url->link('account/login', '', 'SSL')); 
    	} 
			
    	$this->language->load('account/address');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('account/address');
		
    	if (isset($this->request->get['address_id']) && $this->validateDelete()) {
			$this->model_account_address->deleteAddress($this->request->get['address_id']);	
			
			// Default Shipping Address
			if (isset($this->session->data['shipping_address_id']) && ($this->request->get['address_id'] == $this->session->data['shipping_address_id'])) {
				unset($this->session->data['shipping_address_id']);
				unset($this->session->data['shipping_province_id']);
				unset($this->session->data['shipping_postcode']);				
				unset($this->session->data['shipping_method']);
				unset($this->session->data['shipping_methods']);
			}
			
			// Default Payment Address
			if (isset($this->session->data['payment_address_id']) && ($this->request->get['address_id'] == $this->session->data['payment_address_id'])) {
				unset($this->session->data['payment_address_id']);
				unset($this->session->data['payment_province_id']);				
				unset($this->session->data['payment_method']);
				unset($this->session->data['payment_methods']);
			}
			
			$this->session->data['success'] = $this->language->get('text_delete');
	  
	  		$this->redirect($this->url->link('account/address', '', 'SSL'));
    	}
	
		$this->getList();	
  	}

  	protected function getList() {
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
			'href'      => $this->url->link('account/address', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);
			
    	$this->data['heading_title'] = $this->language->get('heading_title');

    	$this->data['text_address_book'] = $this->language->get('text_address_book');
   
    	$this->data['button_new_address'] = $this->language->get('button_new_address');
    	$this->data['button_edit'] = $this->language->get('button_edit');
    	$this->data['button_delete'] = $this->language->get('button_delete');
		$this->data['button_back'] = $this->language->get('button_back');

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
		
    	$this->data['addresses'] = array();
		
		$results = $this->model_account_address->getAddresses();

    	foreach ($results as $result) {

			$format = '{area_zone}' . "\n" . '{address}' . "\n" . '{company}'  . "\n" . '{postcode}' . "\n" .'{fullname}' . "\n" .'{telephone}';
		
    		$find = array(
	  			'{area_zone}',	  			
      			'{address}',
                '{company}',
      			'{postcode}',
                '{fullname}',
      			'{telephone}',
			);
	
			$replace = array(
                'area_zone' => $result['area_zone'],
                'address'   => $result['address'],
                'company'   => $result['company'],
      			'postcode'  => $result['postcode'],
                'fullname'  => $result['fullname'],                 
                'telephone' => $result['telephone'],      			
			);

      		$this->data['addresses'][] = array(
        		'address_id' => $result['address_id'],
        		'address'    => str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format)))),
        		'update'     => $this->url->link('account/address/update', 'address_id=' . $result['address_id'], 'SSL'),
				'delete'     => $this->url->link('account/address/delete', 'address_id=' . $result['address_id'], 'SSL')
      		);
    	}

    	$this->data['insert'] = $this->url->link('account/address/insert', '', 'SSL');
		$this->data['back'] = $this->url->link('account/account', '', 'SSL');
				
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/address_list.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/address_list.tpl';
		} else {
			$this->template = 'default/template/account/address_list.tpl';
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

  	protected function getForm() {
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
			'href'      => $this->url->link('account/address', '', 'SSL'),        	
        	'separator' => $this->language->get('text_separator')
      	);
		
		if (!isset($this->request->get['address_id'])) {
      		$this->data['breadcrumbs'][] = array(
        		'text'      => $this->language->get('text_edit_address'),
				'href'      => $this->url->link('account/address/insert', '', 'SSL'),       		
        		'separator' => $this->language->get('text_separator')
      		);
		} else {
      		$this->data['breadcrumbs'][] = array(
        		'text'      => $this->language->get('text_edit_address'),
				'href'      => $this->url->link('account/address/update', 'address_id=' . $this->request->get['address_id'], 'SSL'),       		
        		'separator' => $this->language->get('text_separator')
      		);
		}
						
    	$this->data['heading_title'] = $this->language->get('heading_title');
    	
		$this->data['text_edit_address'] = $this->language->get('text_edit_address');
    	$this->data['text_yes'] = $this->language->get('text_yes');
    	$this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_select'] = $this->language->get('text_select');
		$this->data['text_none'] = $this->language->get('text_none');
		
    	$this->data['entry_fullname'] = $this->language->get('entry_fullname');
    	$this->data['entry_telephone'] = $this->language->get('entry_telephone');
    	$this->data['entry_company'] = $this->language->get('entry_company');
    	$this->data['entry_address'] = $this->language->get('entry_address');
    	$this->data['entry_postcode'] = $this->language->get('entry_postcode');
    	$this->data['entry_area_zone'] = $this->language->get('entry_area_zone');
    	$this->data['entry_province'] = $this->language->get('entry_province');
    	$this->data['entry_default'] = $this->language->get('entry_default');

    	$this->data['button_continue'] = $this->language->get('button_continue');
    	$this->data['button_back'] = $this->language->get('button_back');
        $this->document->addScript('market/view/theme/'.$this->area_js());
		if (isset($this->error['fullname'])) {
    		$this->data['error_fullname'] = $this->error['fullname'];
		} else {
			$this->data['error_fullname'] = '';
		}
		
		if (isset($this->error['telephone'])) {
    		$this->data['error_telephone'] = $this->error['telephone'];
		} else {
			$this->data['error_telephone'] = '';
		}
										
		if (isset($this->error['address'])) {
    		$this->data['error_address'] = $this->error['address'];
		} else {
			$this->data['error_address'] = '';
		}
		
		if (isset($this->error['area_zone'])) {
    		$this->data['error_area_zone'] = $this->error['area_zone'];
		} else {
			$this->data['error_area_zone'] = '';
		}
		
		if (isset($this->error['postcode'])) {
    		$this->data['error_postcode'] = $this->error['postcode'];
		} else {
			$this->data['error_postcode'] = '';
		}

		if (isset($this->error['province'])) {
			$this->data['error_province'] = $this->error['province'];
		} else {
			$this->data['error_province'] = '';
		}
		
		if (!isset($this->request->get['address_id'])) {
    		$this->data['action'] = $this->url->link('account/address/insert', '', 'SSL');
		} else {
    		$this->data['action'] = $this->url->link('account/address/update', 'address_id=' . $this->request->get['address_id'], 'SSL');
		}
		
    	if (isset($this->request->get['address_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$address_info = $this->model_account_address->getAddress($this->request->get['address_id']);
		}
	
    	if (isset($this->request->post['fullname'])) {
      		$this->data['fullname'] = $this->request->post['fullname'];
    	} elseif (!empty($address_info['fullname'])) {
      		$this->data['fullname'] = $address_info['fullname'];
    	} else {
			$this->data['fullname'] = '';
		}

    	if (isset($this->request->post['telephone'])) {
      		$this->data['telephone'] = $this->request->post['telephone'];
    	} elseif (!empty($address_info['telephone'])) {
      		$this->data['telephone'] = $address_info['telephone'];
    	} else {
			$this->data['telephone'] = '';
		}

    	if (isset($this->request->post['company'])) {
      		$this->data['company'] = $this->request->post['company'];
    	} elseif (!empty($address_info['company'])) {
			$this->data['company'] = $address_info['company'];
		} else {
      		$this->data['company'] = '';
    	}
								
    	if (isset($this->request->post['address'])) {
      		$this->data['address'] = $this->request->post['address'];
    	} elseif (!empty($address_info['address'])) {
			$this->data['address'] = $address_info['address'];
		} else {
      		$this->data['address'] = '';
    	}

    	if (isset($this->request->post['postcode'])) {
      		$this->data['postcode'] = $this->request->post['postcode'];
    	} elseif (!empty($address_info['postcode'])) {
			$this->data['postcode'] = $address_info['postcode'];			
		} else {
      		$this->data['postcode'] = '';
    	}

    	if (isset($this->request->post['areas'])) {
      		$this->data['areas'] = $this->request->post['areas'];
    	} elseif (!empty($address_info['areas'])) {
			$this->data['areas'] = $address_info['areas'];
		} else {
      		$this->data['areas'] = '';
    	}

        if (isset($this->request->post['area_zone'])) {
            $this->data['area_zone'] = $this->request->post['area_zone'];
        } elseif (!empty($address_info['area_zone'])) {
            $this->data['area_zone'] = $address_info['area_zone'];
        } else {
            $this->data['area_zone'] = '';
        }

    	if (isset($this->request->post['province_id'])) {
      		$this->data['province_id'] = $this->request->post['province_id'];
    	}  elseif (!empty($address_info['province_id'])) {
      		$this->data['province_id'] = $address_info['province_id'];
    	} else {
      		$this->data['province_id'] = $this->config->get('config_province_id');
    	}
		

    	if (isset($this->request->post['default'])) {
      		$this->data['default'] = $this->request->post['default'];
    	} elseif (isset($this->request->get['address_id'])) {
      		$this->data['default'] = $this->customer->getAddressId() == $this->request->get['address_id'];
    	} else {
			$this->data['default'] = false;
		}

    	$this->data['back'] = $this->url->link('account/address', '', 'SSL');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/address_form.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/address_form.tpl';
		} else {
			$this->template = 'default/template/account/address_form.tpl';
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
	
  	protected function validateForm() {
    	if ((utf8_strlen($this->request->post['fullname']) < 1) || (utf8_strlen($this->request->post['fullname']) > 32)) {
      		$this->error['fullname'] = $this->language->get('error_fullname');
    	}

        if ((utf8_strlen($this->request->post['telephone']) < 1) || (!isMobile($this->request->post['telephone']))) {
            $this->error['telephone'] = $this->language->get('error_telephone');
        }

    	if ((utf8_strlen($this->request->post['address']) < 3) || (utf8_strlen($this->request->post['address']) > 128)) {
      		$this->error['address'] = $this->language->get('error_address');
    	}

    	if ((utf8_strlen($this->request->post['areas']) < 2) ) {
      		$this->error['areas'] = $this->language->get('error_areas');
    	}
		

		if ( (utf8_strlen($this->request->post['postcode']) < 2) || (utf8_strlen($this->request->post['postcode']) > 10)) {
			$this->error['postcode'] = $this->language->get('error_postcode');
		}

		
    	if (!isset($this->request->post['province_id']) || $this->request->post['province_id'] == '') {
      		$this->error['province'] = $this->language->get('error_province');
    	}
		
    	if (!$this->error) {
      		return true;
		} else {
      		return false;
    	}
  	}

  	protected function validateDelete() {
    	if ($this->model_account_address->getTotalAddresses() == 1) {
      		$this->error['warning'] = $this->language->get('error_delete');
    	}

    	if ($this->customer->getAddressId() == $this->request->get['address_id']) {
      		$this->error['warning'] = $this->language->get('error_default');
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
