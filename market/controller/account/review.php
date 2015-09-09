<?php
class ControllerAccountReview extends Controller {
	public function index() {
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/review', '', 'SSL');
			
	  		$this->redirect($this->url->link('account/login', '', 'SSL'));
    	}		

		$this->language->load('account/review');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addScript('market/view/theme/yuankong/javascript/click.js');
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
        	'text'      => $this->language->get('text_review'),
			'href'      => $this->url->link('account/review', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);
		
		$this->load->model('account/review');
		$this->load->model('account/order');

    	$this->data['heading_title'] = $this->language->get('heading_title');		

		$this->data['text_total'] = $this->language->get('text_total');
		$this->data['text_empty'] = $this->language->get('text_empty');
		$this->data['unreview'] = $this->url->link('account/review','tab=unreview','SSL');
		$this->data['reviewed'] = $this->url->link('account/review','tab=reviewed','SSL');		
				
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}		
		$data = array(				  
			'sort'  => 'date_added',
			'order' => 'DESC',
			'start' => ($page - 1) * 10,
			'limit' => 10
		);
		$this->data['reviews'] = $this->data['products'] = array();
		$tab = isset($this->request->get['tab']) ? strtolower(trim($this->request->get['tab'])) : 'unreview';
		switch ($tab) {
			case 'reviewed':
				$total = $this->model_account_review->getTotalReviews($data);
				$results = $this->model_account_review->getReviews($data);
		    	foreach ($results as $result) {
					$this->data['reviews'][] = array(
						'review_id'	=> $result['review_id'],
						'order_id' 	=> $result['order_id'],
						'status' 	=> $result['status'] ? '审核通过' : '待审核',
						'text' 	=> $result['text'],
						'date'  => date('Y-m-d', strtotime($result['date_added'])),
						'link'  => $this->url->link('account/review/info', 'order_id='.$result['order_id'].'&product_id=' . $result['product_id'],'SSL')
					);
				}	
				break;
			default :				
				$results = $this->model_account_review->getUnreviewOrderProducts($data);
		    	foreach ($results as $product) {	    		
	    			$option_data = array();            
	                $options = $this->model_account_order->getOrderOptions($product['order_id'], $product['order_product_id']);
	                foreach ($options as $option) {
	                    if ($option['type'] != 'file') {
	                        $value = $option['value'];
	                    } else {
	                        $value = utf8_substr($option['value'], 0, utf8_strrpos($option['value'], '.'));
	                    }	                    
	                    $option_data[] = array(
	                        'name'  => $option['name'],
	                        'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
	                    );                  
	                }
	    			$this->data['products'][] = array(
	    				'name'     => $product['name'],
	    				'order_id' => $product['order_id'],
	    				'option'   => $option_data,
                		'model'    => $product['model'],
                		'quantity' => $product['quantity'],
                		'date' 	   => date('Y-m-d',strtotime($product['order_date'])),
                		'link'     => $this->url->link('account/review/info', 'order_id='.$product['order_id'].'&product_id=' . $product['product_id'],'SSL')
	    			);					
				}
				$total = count($this->data['products']);
				break;
		}
		$url = '';
		if(isset($this->request->get['tab'])){
			$url .= '&tab='.strtolower($this->request->get['tab']);
		}else{
			$url .= '&tab=unreview';
		}
		$pagination = new Pagination();
		$pagination->total = $total;
		$pagination->page = $page;
		$pagination->limit = 10; 
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('account/review', 'page={page}'.$url, 'SSL');
					
		$this->data['pagination'] = $pagination->render_page();
		$this->data['tab'] = $tab;
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/review.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/review.tpl';
		} else {
			$this->template = 'default/template/account/review.tpl';
		}
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/footer',
			'common/header'	
		);
						
		$this->response->setOutput($this->render());		
	} 		

	public function info(){
		if (!$this->customer->isLogged()) {
			$this->session->data['redirect'] = $this->url->link('account/review', '', 'SSL');
			
	  		$this->redirect($this->url->link('account/login', '', 'SSL'));
    	}		

		$this->language->load('account/review');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addScript('market/view/theme/yuankong/javascript/click.js');
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
        	'text'      => $this->language->get('text_review'),
			'href'      => $this->url->link('account/review', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);
      	$this->data['breadcrumbs'][] = array(       	
        	'text'      => '#'.$this->request->get['order_id'],
			'href'      => $this->url->link('account/review/info', '', 'SSL'),
        	'separator' => $this->language->get('text_separator')
      	);
		$order_id = isset($this->request->get['order_id']) ? (int)$this->request->get['order_id'] : false;
		$product_id = isset($this->request->get['product_id']) ? (int)$this->request->get['product_id'] : false;
		$this->load->model('account/review');
		
		$info = $this->model_account_review->getOrderAndProduct($order_id,$product_id);

		if($info){
			$this->data['product'] = $info['name'];
			$this->data['model'] = $info['model'];
			$this->data['quantity'] = $info['quantity'];
			$this->load->model('account/order');
			$this->data['options'] = $this->model_account_order->getOrderOptions($order_id,$info['order_product_id']);		
			$this->data['order_id'] = $order_id;
			$this->data['product_id'] = $product_id;
			$this->data['link'] = $product_id;
		}else{
			//$this->redirect($this->url->link('account/review','','SSL'));
		}
		$this->template = $this->config->get('config_template') . '/template/account/review_info.tpl';
		
		$this->children = array(
			'common/column_left',
			'common/column_right',
			'common/footer',
			'common/header'	
		);
						
		$this->response->setOutput($this->render());	
	}

	public function write() {
		$this->language->load('account/review');
		
		$this->load->model('account/review');
		
		$json = array();
		
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			if (!$this->customer->isLogged()) {
				$json['error']['login'] = $this->language->get('error_login');
			}
			
			if ((utf8_strlen($this->request->post['text']) < 3) || (utf8_strlen($this->request->post['text']) > 1000)) {
				$json['error']['text'] = $this->language->get('error_text');
			}
	
			if (empty($this->request->post['rating'])) {
				$json['error']['rating'] = $this->language->get('error_rating');
			}

			if (empty($this->request->post['shipping'])) {
				$json['error']['shipping'] = $this->language->get('error_shipping');
			}

			if (empty($this->request->post['service'])) {
				$json['error']['service'] = $this->language->get('error_service');
			}
				
			if (!isset($json['error'])) {
				$this->load->model('account/review');
		
				$info = $this->model_account_review->getOrderAndProduct($this->request->post['order_id'],$this->request->post['product_id']);
				if($info){
					$this->model_account_review->addReview($this->request->post);					
					$json = array('status'=>1, 'msg' => $this->language->get('text_success'));
				}else{
					$json = array('status'=>0,'msg'=>$this->language->get('error_data'));
				}
			}else{
				$json = array('status'=>0,'error'=>$json['error']);
			}
		}
		
		$this->response->setOutput(json_encode($json));
	}

	function delete(){

  		$this->load->model('account/review');
  		$review_id = isset($this->request->post['review_id']) ? $this->request->post['review_id'] : false;
  		if($review_id){
  			$this->model_account_review->delate($review_id);
  			$json = array('status'=>1,'msg'=>'删除成功');
  		}else{
  			$json = array('status'=>0,'msg'=>$this->language->get('error_delete_order'));
  		}
  		$this->response->setOutput(json_encode($json_encode));	
	}
}
