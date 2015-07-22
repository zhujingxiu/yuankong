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

		$this->data['column_name'] = $this->language->get('column_name');
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
			$area = $this->cache->get('area');
			if(!$area){
				$area = $this->render_tree($this->model_localisation_area->getAreaTree(null));
				$this->cache->set('area',$area);
			}            
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
                $parent_area = $this->model_localisation_area->getParentArea($item['area_id']);
                $tmp['attributes'] = array(
                    'area_id'   => $item['area_id'],
                    'title'     => $item['name'],
                    'pid'      => $item['pid'],
                    'p_name'	=> empty($parent_area['name']) ? '' : $parent_area['name'],
                    'status'    => $item['status'],
                    'sort'      => $item['sort'],
                );

                if(isset($item['children']) && is_array($item['children'])){
                    $tmp['children'] = $this->render_tree($item['children']);
                }else{
                    $tmp['attributes']['rel'] = "file";
                    $tmp['attributes']['class'] = 'leaf';
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

    public function save() {
        $this->language->load('localisation/area');

        $this->document->setTitle($this->language->get('heading_title'));
    
        $this->load->model('localisation/area');
    
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm('localisation/area/save')) {
            if($this->model_localisation_area->saveArea($this->request->post)){
                $data = array('status'=>1,'msg'=>$this->language->get('text_success'));
            }else{              
                $data = array('status'=>0,'msg'=>$this->language->get('text_error'));
            }
            $this->response->setOutput(json_encode($data)); 
        }
    }

    public function delete() { 
        $this->language->load('localisation/area');

        $this->document->setTitle($this->language->get('heading_title'));
    
        $this->load->model('localisation/area');
    
        if (isset($this->request->post['area_id']) && $this->validateDelete('localisation/area/delete')) {
            if($this->model_localisation_area->deleteNode($this->request->post['area_id'])){
                $this->response->setOutput(json_encode(array('status'=>1,'msg'=>'已删除')));  
            }
        }   
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

    protected function validateDelete($route) { 
        if (!$this->user->hasPermission('modify', $route)) {
            $this->error['warning'] = $this->language->get('error_permission');
        } 
        if (!isset($this->request->post['area_id'])) {
            $this->error['warning'] = $this->language->get('text_error');
        }
        if (!$this->error) {
            return true;
        } else { 
            return false;
        }
    }
}