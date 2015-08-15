<?php
class ControllerPaymentchinapay extends Controller {
	public function index() {
		$this->language->load('payment/chinapay');

		$this->data['text_testmode'] = $this->language->get('text_testmode');		

		$this->data['button_confirm'] = $this->language->get('button_confirm');

		$this->load->model('checkout/order');

		$order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);
		
		$total = $order_info['total'];

		if ($total > 0) {
			$tdata['products'][] = array(
				'name'     => $this->language->get('text_total'),
				'model'    => '',
				'price'    => $total,
				'quantity' => 1,
				'option'   => array(),
				'weight'   => 0
			);	
		} else {
			$this->data['discount_amount_cart'] -= $total;
		}
			
	
        $this->data['remark2'] = '[url:=' . HTTP_SERVER . 'index.php?route=payment/chinapay/callback]';
        $this->data['v_mid'] = trim($this->config->get('chinapay_id'));
        $this->data['key'] = trim($this->config->get('chinapay_key'));
        $this->data['v_oid'] = trim($this->session->data['order_id']);
        $this->data['v_amount'] = round($total,2);
        $this->data['v_moneytype'] = "CNY";//$order_info['currency_code'];
        $this->data['v_url'] = HTTP_SERVER . 'index.php?route=payment/chinapay/callback';
        $this->data['text'] = $this->data['v_amount'].$this->data['v_moneytype'].$this->data['v_oid'].$this->data['v_mid'].$this->data['v_url'].$this->data['key']; 
        $this->data['v_md5info'] = strtoupper(md5($this->data['text']));
        $this->data['remark1'] = $order_info['order_id'];

		$this->data['cancel_return'] = $this->url->link('checkout/checkout', '', 'SSL');
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/chinapay.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/payment/chinapay.tpl';
        } else {
            $this->template = 'default/template/payment/chinapay.tpl';
        }   
        
        $this->render(); 

	}
					
	public function callback() {		

		$this->load->model('checkout/order');
		
		$order_status_id = $this->config->get('config_order_status_id');
		
		$order_id  = trim($this->request->post['v_oid']);
		
		$order_info = $this->model_checkout_order->getOrder($order_id);
		
        $v_oid     = trim($this->request->post['v_oid']);     
        $v_pmode   = trim($this->request->post['v_pmode']);  
        $v_pstatus = trim($this->request->post['v_pstatus']);  
        $v_pstring = trim($this->request->post['v_pstring']);  
        $v_amount  = trim($this->request->post['v_amount']);     
        $v_moneytype  = trim($this->request->post['v_moneytype']); 
        $remark1   = trim($this->request->post['remark1' ]);   
        $remark2   = trim($this->request->post['remark2' ]);    
        $v_md5str  = trim($this->request->post['v_md5str' ]);   
        $key = trim($this->config->get('chinapay_key'));
        $pending = 1;
        $failed = 10;
                           
        $md5string=strtoupper(md5($v_oid.$v_pstatus.$v_amount.$v_moneytype.$key));
        if ($v_md5str==$md5string){
            if($v_pstatus=="20"){
                // Success page redirect
                $this->model_checkout_order->addOrderHistory($order_id, $pending);
                $this->response->redirect($this->url->link('checkout/success'));
            }else {
                // Failure
                $this->model_checkout_order->addOrderHistory($order_id, $failed);
                $this->response->redirect($this->url->link('checkout/failure'));
              }
        }
	}
}
