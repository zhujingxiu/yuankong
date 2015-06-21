<?php 
class ControllerLocalisationArea extends Controller {
	private $error = array(); 

	public function index() {
		$this->language->load('localisation/area');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addScript('view/javascript/jquery/jstree/jquery.tree.min.js');
        $this->document->addScript('view/javascript/jquery/jstree/plugins/jquery.tree.contextmenu.js'); 
		
		$this->load->model('localisation/area');
		
		

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('localisation/area', 'token=' . $this->session->data['token'] , 'SSL'),
      		'separator' => ' :: '
   		);
							
		$this->data['insert'] = $this->url->link('localisation/area/insert', 'token=' . $this->session->data['token'] , 'SSL');
		$this->data['delete'] = $this->url->link('localisation/area/delete', 'token=' . $this->session->data['token'] , 'SSL');
	
		$this->data['heading_title'] = $this->language->get('heading_title');
        $this->data['text_no_results'] = $this->language->get('text_no_results');
        $this->data['text_wait'] = $this->language->get('text_wait');
        $this->data['text_yes'] = $this->language->get('text_yes');
        $this->data['text_no'] = $this->language->get('text_no');
		$this->data['text_no_results'] = $this->language->get('text_no_results');

		$this->data['column_country'] = $this->language->get('column_country');
		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_code'] = $this->language->get('column_code');
		$this->data['column_action'] = $this->language->get('column_action');	

		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_delete'] = $this->language->get('button_delete');
 
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
 

		$this->data['token'] = $this->session->data['token'];
		if(!empty($this->request->get['ajax'])){

            $area = $this->render_tree($this->model_localisation_area->getAreaTree(null),true);
            $this->response->setOutput(json_encode($area));
        }else{
			$this->template = 'localisation/area.tpl';
			$this->children = array(
				'common/header',
				'common/footer'
			);
					
			$this->response->setOutput($this->render());
		}
	}

	private function render_tree($area,$open=false){

        if(is_array($area)){
            $data = array();
            foreach ($area as $key => $item) {
                $tmp = array();
                $tmp['data'] = $item['name'];
                if($open){
                    $tmp['state'] = 'open';
                }
                $tmp['attributes'] = array(
                    'area_id'   => $item['area_id'],
                    'title'     => $item['name'],
                    'level'     => $item['level'],
                    'p_id'      => $item['p_id'],
                    'p_name'    => trim($item['p_name']),
                    'status'    => $item['status'],
                    'sort'      => $item['sort'],
                );

                if(isset($item['children']) && is_array($item['children'])){
                    $tmp['children'] = $this->render_tree($item['children']);
                }else{
                    $tmp['attributes']['rel'] = "file";
                }
                $data[] = $tmp;
            }
            return $data;
        }
        return false;
    }

	public function insert() {
		$this->language->load('localisation/area');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('localisation/area');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_localisation_area->addArea($this->request->post);
	
			$this->session->data['success'] = $this->language->get('text_success');
			
			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->redirect($this->url->link('localisation/area', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function update() {
		$this->language->load('localisation/area');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('localisation/area');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_localisation_area->editArea($this->request->get['area_id'], $this->request->post);			
			
			$this->session->data['success'] = $this->language->get('text_success');
			
			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}
			
			$this->redirect($this->url->link('localisation/area', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete() {
		$this->language->load('localisation/area');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('localisation/area');
		
		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $area_id) {
				$this->model_localisation_area->deleteArea($area_id);
			}			
			
			$this->session->data['success'] = $this->language->get('text_success');
			
			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->redirect($this->url->link('localisation/area', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}


	protected function getForm() {
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_code'] = $this->language->get('entry_code');
		$this->data['entry_country'] = $this->language->get('entry_country');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

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
		
		$url = '';
			
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),  		
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('localisation/area', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
							
		if (!isset($this->request->get['area_id'])) {
			$this->data['action'] = $this->url->link('localisation/area/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('localisation/area/update', 'token=' . $this->session->data['token'] . '&area_id=' . $this->request->get['area_id'] . $url, 'SSL');
		}
		 
		$this->data['cancel'] = $this->url->link('localisation/area', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['area_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$area_info = $this->model_localisation_area->getArea($this->request->get['area_id']);
		}

		if (isset($this->request->post['status'])) {
			$this->data['status'] = $this->request->post['status'];
		} elseif (!empty($area_info)) {
			$this->data['status'] = $area_info['status'];
		} else {
			$this->data['status'] = '1';
		}
		
		if (isset($this->request->post['name'])) {
			$this->data['name'] = $this->request->post['name'];
		} elseif (!empty($area_info)) {
			$this->data['name'] = $area_info['name'];
		} else {
			$this->data['name'] = '';
		}

		if (isset($this->request->post['code'])) {
			$this->data['code'] = $this->request->post['code'];
		} elseif (!empty($area_info)) {
			$this->data['code'] = $area_info['code'];
		} else {
			$this->data['code'] = '';
		}

		if (isset($this->request->post['country_id'])) {
			$this->data['country_id'] = $this->request->post['country_id'];
		} elseif (!empty($area_info)) {
			$this->data['country_id'] = $area_info['country_id'];
		} else {
			$this->data['country_id'] = '';
		}
		
		$this->load->model('localisation/country');
		
		$this->data['countries'] = $this->model_localisation_country->getCountries();

		$this->template = 'localisation/area_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'localisation/area')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
			$this->error['name'] = $this->language->get('error_name');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'localisation/area')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		$this->load->model('setting/store');
		$this->load->model('sale/customer');
		$this->load->model('sale/affiliate');
		$this->load->model('localisation/geo_area');
		
		foreach ($this->request->post['selected'] as $area_id) {
			if ($this->config->get('config_area_id') == $area_id) {
				$this->error['warning'] = $this->language->get('error_default');
			}
			
			$store_total = $this->model_setting_store->getTotalStoresByAreaId($area_id);

			if ($store_total) {
				$this->error['warning'] = sprintf($this->language->get('error_store'), $store_total);
			}
		
			$address_total = $this->model_sale_customer->getTotalAddressesByAreaId($area_id);

			if ($address_total) {
				$this->error['warning'] = sprintf($this->language->get('error_address'), $address_total);
			}

			$affiliate_total = $this->model_sale_affiliate->getTotalAffiliatesByAreaId($area_id);

			if ($affiliate_total) {
				$this->error['warning'] = sprintf($this->language->get('error_affiliate'), $affiliate_total);
			}
					
			$area_to_geo_area_total = $this->model_localisation_geo_area->getTotalAreaToGeoAreaByAreaId($area_id);
		
			if ($area_to_geo_area_total) {
				$this->error['warning'] = sprintf($this->language->get('error_area_to_geo_area'), $area_to_geo_area_total);
			}
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
}