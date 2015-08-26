<?php 
class ControllerAccountAccount extends Controller { 
	public function index() {
		if (!$this->customer->isLogged()) {
	  		$this->session->data['redirect'] = $this->url->link('account/account', '', 'SSL');
	  
	  		$this->redirect($this->url->link('account/login', '', 'SSL'));
    	} 
		$this->language->load('account/account');

		$this->document->setTitle($this->language->get('heading_title'));

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
		
		if (isset($this->session->data['success'])) {
    		$this->data['success'] = $this->session->data['success'];
			
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		
    	$this->data['heading_title'] = $this->language->get('heading_title');

    	$this->data['text_my_account'] = $this->language->get('text_my_account');
        $this->data['text_my_orders'] = $this->language->get('text_my_orders');
		$this->data['text_recently'] = $this->language->get('text_recently');
		$this->data['text_my_newsletter'] = $this->language->get('text_my_newsletter');
    	$this->data['text_edit'] = $this->language->get('text_edit');
    	$this->data['text_password'] = $this->language->get('text_password');
    	$this->data['text_address'] = $this->language->get('text_address');
		$this->data['text_wishlist'] = $this->language->get('text_wishlist');
    	$this->data['text_order'] = $this->language->get('text_order');
    	$this->data['text_download'] = $this->language->get('text_download');
		$this->data['text_reward'] = $this->language->get('text_reward');
		$this->data['text_return'] = $this->language->get('text_return');
		$this->data['text_transaction'] = $this->language->get('text_transaction');
		$this->data['text_newsletter'] = $this->language->get('text_newsletter');

    	$this->data['edit'] = $this->url->link('account/edit', '', 'SSL');
    	$this->data['password'] = $this->url->link('account/password', '', 'SSL');
		$this->data['address'] = $this->url->link('account/address', '', 'SSL');
		$this->data['wishlist'] = $this->url->link('account/wishlist');
    	$this->data['order'] = $this->url->link('account/order', '', 'SSL');
    	$this->data['download'] = $this->url->link('account/download', '', 'SSL');
		$this->data['return'] = $this->url->link('account/return', '', 'SSL');
		$this->data['transaction'] = $this->url->link('account/transaction', '', 'SSL');
        $this->data['newsletter'] = $this->url->link('account/newsletter', '', 'SSL');
        $this->data['finish'] = $this->url->link('account/order', 'status=finished', 'SSL');
		$this->data['fullname'] = ($this->customer->isCompany() ? $this->customer->getCompany() : $this->customer->getFullName());
        $this->load->model('tool/image');
        $this->load->model('account/order');
        $this->load->model('catalog/product');
        $this->load->model('account/customer');
        $this->data['messages'] = $this->model_account_customer->getTotalMessages();
        $this->data['message'] = $this->url->link('account/message','','SSL');
        $this->data['reviews'] = $this->model_account_customer->getTotalReviews();
        $this->data['review'] = $this->url->link('account/review','','SSL');
        $this->data['helps'] = $this->model_account_customer->getTotalHelps();
        $this->data['help'] = $this->url->link('account/help','','SSL');
        $this->data['recently'] = array();
        $results = $this->model_account_order->getOrders(0,5);
       	$already = array();
        foreach ($results as $result) {
            $product = '';
            $products = $this->model_account_order->getOrderProducts($result['order_id']);
            foreach ($products as $item) {
            	$already[] = $item['product_id'];
                $parent_id = $this->model_catalog_product->getProductCategories($item['product_id']);
            	
                $path = $this->model_catalog_product->getCategoryPath($parent_id);
                
                $path_param = empty($path) ? '' : '&path='.$path;
                $product[] = array('name'=>$item['name'],'link'=> $this->url->link('product/product', $path_param.'&product_id=' . $item['product_id'] ) );
            }
            $this->data['recently'][] = array(
                'date_added'=> date('Y-m-d',strtotime($result['date_added'])),
                'products'  => $product,
                'total'     => $this->currency->format($result['total']),
                'status'    => $result['status'],
                'link'      => $this->url->link('account/order/info', 'order_id=' . $result['order_id'],'SSL')
            );
        }
        $this->data['totals'] = $this->model_account_order->getTotalOrders();
        $this->data['finished'] = $this->model_account_order->getTotalFinishedOrders();
        $avatar = $this->customer->getAvatar();
        $this->data['avatar'] = empty($avatar) ? TPL_IMG.'avatar/default.jpg' : $avatar;
        $this->data['quickavatar'] = $this->url->link('account/edit','quick=avatar','SSL');
		if ($this->config->get('reward_status')) {
			$this->data['reward'] = $this->url->link('account/reward', '', 'SSL');
		} else {
			$this->data['reward'] = '';
		}
		 $this->data['recomments'] = array();
		$recomments = $this->model_account_customer->getRecomments($already);
		if(count($recomments)<5){
            $products = explode(',', $this->config->get('featured_product'));       

            if (empty($setting['limit'])) {
                $setting['limit'] = 5-count($recomments) ;
            }
            
            $products = array_slice($products, 0, (int)$setting['limit']);
            $recomments = array_merge($recomments,$products);
        }
       
        $recomments = array_unique($recomments);
        if(count($recomments)>3){
        	$recomments = array_slice($recomments,1,3);
        }
        
        if($recomments){
            foreach ($recomments as $product_id) {

                $product_info = $this->model_catalog_product->getProduct($product_id);

                if ($product_info) { 
                    if ($product_info['image']) {
                        $image = $this->model_tool_image->resize($product_info['image'], 171, 100);
                    } else {
                        $image = false;
                    }
                                
                    if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                        $price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
                    } else {
                        $price = false;
                    }
                            
                    if ((float)$product_info['special']) {
                        $special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
                    } else {
                        $special = false;
                    }
                    
                    if ($this->config->get('config_review_status')) {
                        $rating = $product_info['rating'];
                    } else {
                        $rating = false;
                    }
                    $category_id = $this->model_catalog_product->getProductCategories($product_id);
                    $path = $this->model_catalog_product->getCategoryPath($category_id);            
                    $path_param = empty($path) ? '' : '&path='.$path;
                    $this->data['recomments'][] = array(
                        'product_id' => $product_info['product_id'],
                        'thumb'      => $image,
                        'name'       => $product_info['name'],
                        'subtitle'       => $product_info['subtitle'],
                        'price'      => $price,
                        'special'    => $special,
                        'rating'     => $rating,
                        'reviews'    => sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']),
                        'href'       => $this->url->link('product/product', 'product_id=' . $product_info['product_id'].$path_param),
                    );
                }
            }
        }
		//$this->data['recomments'] = array_sh
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/account/account.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/account/account.tpl';
		} else {
			$this->template = 'default/template/account/account.tpl';
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
}