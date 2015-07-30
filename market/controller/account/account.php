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
		$this->data['fullname'] = $this->customer->getFullname();
        $this->load->model('account/order');
        $this->load->model('catalog/product');
        $this->data['recently'] = array();
        $results = $this->model_account_order->getOrders(0,5);

        foreach ($results as $result) {
            $product = '';
            $products = $this->model_account_order->getOrderProducts($result['order_id']);
            foreach ($products as $item) {
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

		if ($this->config->get('reward_status')) {
			$this->data['reward'] = $this->url->link('account/reward', '', 'SSL');
		} else {
			$this->data['reward'] = '';
		}
		
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
?>