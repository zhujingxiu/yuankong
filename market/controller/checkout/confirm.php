<?php 
class ControllerCheckoutConfirm extends Controller { 
	protected $error= array();
	public function index() {
		$redirect = '';
		// Validate if customer is logged in.
		if (!$this->customer->isLogged()) {
			$redirect = $this->url->link('checkout/checkout', '', 'SSL');
		}
		
		// Validate if shipping is required. If not the customer should not have reached this page.
		if (!$this->checkout->hasShipping()) {
			$redirect = $this->url->link('checkout/checkout', '', 'SSL');
		}
		
		// Validate check has products and has stock.		
		if ((!$this->checkout->hasProducts() && empty($this->session->data['vouchers'])) || (!$this->checkout->hasStock() && !$this->config->get('config_stock_checkout'))) {
			$redirect = $this->url->link('checkout/cart');
		}
				// Validate minimum quantity requirments.			
		$products = $this->checkout->getProducts();
				
		foreach ($products as $product) {
			$product_total = 0;
				
			foreach ($products as $product_2) {
				if ($product_2['product_id'] == $product['product_id']) {
					$product_total += $product_2['quantity'];
				}
			}		
			
			if ($product['minimum'] > $product_total) {
				$redirect = $this->url->link('checkout/cart');
				
				break;
			}				
		}
		$json = array();
		if($this->validateShipping()){
			if ($this->checkout->hasShipping()) {
				// Validate if shipping address has been set.		
				$this->load->model('account/address');
		
				if ($this->customer->isLogged() && isset($this->session->data['shipping_address_id'])) {					
					$shipping_address = $this->model_account_address->getAddress($this->session->data['shipping_address_id']);		
				} 
				
				if (empty($shipping_address)) {								
					$redirect = $this->url->link('checkout/checkout', '', 'SSL');
				}
				
				// Validate if shipping method has been set.	
				if (!isset($this->session->data['shipping_method'])) {
					$redirect = $this->url->link('checkout/checkout', '', 'SSL');
				}
			} else {
				unset($this->session->data['shipping_method']);
				unset($this->session->data['shipping_methods']);
			}
			
			// Validate if payment address has been set.
			$this->load->model('account/address');		
		}else{
			$redirect = $this->url->link('checkout/checkout', '', 'SSL');
			$json['status'] = 0;
			$json['error_shipping'] = isset($this->error['shipping']) ? $this->error['shipping'] : array();
			$json['redirect'] = $redirect;
		}

		if($this->validatePayment()){
			// Validate if payment method has been set.	
			if (!isset($this->session->data['payment_method'])) {
				$redirect = $this->url->link('checkout/checkout', '', 'SSL');
			}
		}else{
			$redirect = $this->url->link('checkout/checkout', '', 'SSL');
			$json['status'] = 0;
			$json['error_payment'] = isset($this->error['payment']) ? $this->error['payment'] : array();
			$json['redirect'] = $redirect;
		}

		if (!$redirect) {
			$total_data = array();
			$total = 0;
			$taxes = $this->checkout->getTaxes();
			 
			$this->load->model('setting/extension');
			
			$sort_order = array(); 
			
			$results = $this->model_setting_extension->getExtensions('total');
			
			foreach ($results as $key => $value) {
				$sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
			}
			
			array_multisort($sort_order, SORT_ASC, $results);
			
			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					$this->load->model('total/' . $result['code']);
		
					$this->{'model_total_' . $result['code']}->getCheckoutTotal($total_data, $total, $taxes);
				}
			}
			
			$sort_order = array(); 
		  
			foreach ($total_data as $key => $value) {
				$sort_order[$key] = $value['sort_order'];
			}
	
			array_multisort($sort_order, SORT_ASC, $total_data);
	
			$this->language->load('checkout/checkout');
			
			$data = array();
			
			$data['invoice_prefix'] = $this->config->get('config_invoice_prefix');
			
			if ($this->customer->isLogged()) {
				$data['customer_id'] = $this->customer->getId();
				$data['customer_group_id'] = $this->customer->getCustomerGroupId();
				$data['fullname'] = $this->customer->getFullName();
				$data['mobile_phone'] = $this->customer->getMobilePhone();
				$data['email'] = $this->customer->getEmail();
				$data['telephone'] = $this->customer->getTelephone();
				$data['fax'] = $this->customer->getFax();
			
				$this->load->model('account/address');
			} 
		
			if (isset($this->session->data['payment_method']['title'])) {
				$data['payment_method'] = $this->session->data['payment_method']['title'];
			} else {
				$data['payment_method'] = '';
			}
			
			if (isset($this->session->data['payment_method']['code'])) {
				$data['payment_code'] = $this->session->data['payment_method']['code'];
			} else {
				$data['payment_code'] = '';
			}
						
			if ($this->checkout->hasShipping()) {
				if ($this->customer->isLogged()) {
					$this->load->model('account/address');
					
					$shipping_address = $this->model_account_address->getAddress($this->session->data['shipping_address_id']);	
				} 			
				
				$data['shipping_fullname'] = $shipping_address['fullname'];
				$data['shipping_telephone'] = $shipping_address['telephone'];
				$data['shipping_company'] = $shipping_address['company'];	
				$data['shipping_address'] = $shipping_address['address'];
				$data['shipping_postcode'] = $shipping_address['postcode'];
				$data['shipping_province'] = $shipping_address['province'];
				$data['shipping_area_zone'] = $shipping_address['area_zone'];
				$data['shipping_province_id'] = $shipping_address['province_id'];
			
				if (isset($this->session->data['shipping_method']['title'])) {
					$data['shipping_method'] = $this->session->data['shipping_method']['title'];
				} else {
					$data['shipping_method'] = '';
				}
				
				if (isset($this->session->data['shipping_method']['code'])) {
					$data['shipping_code'] = $this->session->data['shipping_method']['code'];
				} else {
					$data['shipping_code'] = '';
				}				
			} else {
				$data['shipping_fullname'] = '';
				$data['shipping_telephone'] = '';
				$data['shipping_company'] = '';	
				$data['shipping_address'] = '';
				$data['shipping_postcode'] = '';
				$data['shipping_area_zone'] = '';
				$data['shipping_province'] = '';
				$data['shipping_province_id'] = '';
				$data['shipping_method'] = '';
				$data['shipping_code'] = '';
			}
			
			$product_data = array();
		
			foreach ($this->checkout->getProducts() as $product) {
				$option_data = array();
	
				foreach ($product['option'] as $option) {
					if ($option['type'] != 'file') {
						$value = $option['option_value'];	
					} else {
						$value = $this->encryption->decrypt($option['option_value']);
					}	
					
					$option_data[] = array(
						'product_option_id'       => $option['product_option_id'],
						'product_option_value_id' => $option['product_option_value_id'],
						'option_id'               => $option['option_id'],
						'option_value_id'         => $option['option_value_id'],								   
						'name'                    => $option['name'],
						'value'                   => $value,
						'type'                    => $option['type']
					);					
				}
	 
				$product_data[] = array(
					'product_id' => $product['product_id'],
					'name'       => $product['name'],
					'model'      => $product['model'],
					'option'     => $option_data,
					'quantity'   => $product['quantity'],
					'subtract'   => $product['subtract'],
					'price'      => $product['price'],
					'total'      => $product['total'],
					'tax'        => $this->tax->getTax($product['price'], $product['tax_class_id']),
					'reward'     => $product['reward']
				); 
			}
			
			// Gift Voucher
			$voucher_data = array();
			
			if (!empty($this->session->data['vouchers'])) {
				foreach ($this->session->data['vouchers'] as $voucher) {
					$voucher_data[] = array(
						'description'      => $voucher['description'],
						'code'             => substr(md5(mt_rand()), 0, 10),
						'to_name'          => $voucher['to_name'],
						'to_email'         => $voucher['to_email'],
						'from_name'        => $voucher['from_name'],
						'from_email'       => $voucher['from_email'],
						'voucher_theme_id' => $voucher['voucher_theme_id'],
						'message'          => $voucher['message'],						
						'amount'           => $voucher['amount']
					);
				}
			}  
						
			$data['products'] = $product_data;
			$data['vouchers'] = $voucher_data;
			$data['totals'] = $total_data;
			$data['comment'] = isset($this->session->data['comment']) ? $this->session->data['comment'] : '';
			$data['total'] = $total;
			
			if (isset($this->request->cookie['tracking'])) {
				$this->load->model('affiliate/affiliate');
				
				$affiliate_info = $this->model_affiliate_affiliate->getAffiliateByCode($this->request->cookie['tracking']);
				$subtotal = $this->checkout->getSubTotal();
				
				if ($affiliate_info) {
					$data['affiliate_id'] = $affiliate_info['affiliate_id']; 
					$data['commission'] = ($subtotal / 100) * $affiliate_info['commission']; 
				} else {
					$data['affiliate_id'] = 0;
					$data['commission'] = 0;
				}
			} else {
				$data['affiliate_id'] = 0;
				$data['commission'] = 0;
			}
			
			$data['language_id'] = $this->config->get('config_language_id');
			$data['currency_id'] = $this->currency->getId();
			$data['currency_code'] = $this->currency->getCode();
			$data['currency_value'] = $this->currency->getValue($this->currency->getCode());
			$data['ip'] = $this->request->server['REMOTE_ADDR'];
			
			if (!empty($this->request->server['HTTP_X_FORWARDED_FOR'])) {
				$data['forwarded_ip'] = $this->request->server['HTTP_X_FORWARDED_FOR'];	
			} elseif(!empty($this->request->server['HTTP_CLIENT_IP'])) {
				$data['forwarded_ip'] = $this->request->server['HTTP_CLIENT_IP'];	
			} else {
				$data['forwarded_ip'] = '';
			}
			
			if (isset($this->request->server['HTTP_USER_AGENT'])) {
				$data['user_agent'] = $this->request->server['HTTP_USER_AGENT'];	
			} else {
				$data['user_agent'] = '';
			}
			
			if (isset($this->request->server['HTTP_ACCEPT_LANGUAGE'])) {
				$data['accept_language'] = $this->request->server['HTTP_ACCEPT_LANGUAGE'];	
			} else {
				$data['accept_language'] = '';
			}
						
			$this->load->model('checkout/order');
			$data['order_status_id'] = $this->config->get('config_order_status_id');
			$this->session->data['order_id'] = $this->model_checkout_order->addOrder($data);

			$json['status'] = 1;
			$json['redirect'] = $this->url->link('payment/'.$data['payment_code'], '', 'SSL');
		} else {
			$json['status'] = 0;
			$json['redirect'] = $redirect;
		}		
		
		$this->response->setOutput(json_encode($json));	
  	}

  	protected function validateShipping() {
		$this->language->load('checkout/checkout');

		if (isset($this->request->post['shipping_address_id']) && $this->request->post['shipping_address_id']) {
			$this->load->model('account/address');
			
			if (!in_array($this->request->post['shipping_address_id'], array_keys($this->model_account_address->getAddresses()))) {
				$this->error['shipping']['warning'] = $this->language->get('error_address');
			}
			if (!$this->error) {			
				$this->session->data['shipping_address_id'] = $this->request->post['shipping_address_id'];
				
				// Default Shipping Address
				$this->load->model('account/address');

				$address_info = $this->model_account_address->getAddress($this->request->post['shipping_address_id']);
				
				if ($address_info) {
					$this->session->data['shipping_province_id'] = $address_info['province_id'];
					$this->session->data['shipping_postcode'] = $address_info['postcode'];						
				} else {
					unset($this->session->data['shipping_province_id']);	
					unset($this->session->data['shipping_postcode']);
				}
			}
		} else {
			if ((utf8_strlen($this->request->post['fullname']) < 1) || (utf8_strlen($this->request->post['fullname']) > 32)) {
				$this->error['shipping']['fullname'] = $this->language->get('error_fullname');
			}
	
			if ((utf8_strlen($this->request->post['telephone']) < 1) || !isMobile($this->request->post['telephone'])) {
				$this->error['shipping']['telephone'] = $this->language->get('error_telephone');
			}
	
			if ((utf8_strlen($this->request->post['address']) < 3) || (utf8_strlen($this->request->post['address']) > 128)) {
				$this->error['shipping']['address'] = $this->language->get('error_address');
			}							
			
			if (!isset($this->request->post['area']) || !is_array($this->request->post['area']) || !current($this->request->post['area'])) {
				$this->error['shipping']['area'] = $this->language->get('error_area');
			}
			
			if (!isset($this->error['shipping'])) {						
				// Default Shipping Address
				$this->load->model('account/address');		
				
				$this->session->data['shipping_address_id'] = $this->model_account_address->addAddress($this->request->post);
				$this->session->data['shipping_province_id'] = is_array($this->request->post['area']) ? current($this->request->post['area']) : 0;
				$this->session->data['shipping_postcode'] = isset($this->request->post['postcode']) ? $this->request->post['postcode'] : '';
			}
		}

		return !isset($this->error['shipping']);
	}
	
	public function validatePayment() {
		$this->language->load('checkout/checkout');
		
		if (!isset($this->request->post['payment_method'])) {
			$this->error['payment']['warning'] = $this->language->get('error_payment');
		} elseif (!isset($this->session->data['payment_methods'][$this->request->post['payment_method']])) {
			$this->error['payment']['warning'] = $this->language->get('error_payment');
		}	
						
		if ($this->config->get('config_checkout_id')) {
			$this->load->model('catalog/information');
			
			$information_info = $this->model_catalog_information->getInformation($this->config->get('config_checkout_id'));
			
			if ($information_info && !isset($this->request->post['agree'])) {
				$this->error['payment']['warning'] = sprintf($this->language->get('error_agree'), $information_info['title']);
			}
		}
		
		if (!isset($this->error['payment'])) {
			$this->session->data['payment_method'] = $this->session->data['payment_methods'][$this->request->post['payment_method']];
		  
			$this->session->data['comment'] = strip_tags($this->request->post['comment']);
		}							
		
		return !isset($this->error['payment']);
	}
}