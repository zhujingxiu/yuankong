<?php
class ModelTotalShipping extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) {
		if ($this->cart->hasShipping() && isset($this->session->data['shipping_method'])) {
			$total_data[] = array( 
				'code'       => 'shipping',
        		'title'      => $this->session->data['shipping_method']['title'],
        		'text'       => $this->currency->format($this->session->data['shipping_method']['cost']),
        		'value'      => $this->session->data['shipping_method']['cost'],
				'sort_order' => $this->config->get('shipping_sort_order')
			);

			if ($this->session->data['shipping_method']['tax_class_id']) {
				$tax_rates = $this->tax->getRates($this->session->data['shipping_method']['cost'], $this->session->data['shipping_method']['tax_class_id']);
				
				foreach ($tax_rates as $tax_rate) {
					if (!isset($taxes[$tax_rate['tax_rate_id']])) {
						$taxes[$tax_rate['tax_rate_id']] = $tax_rate['amount'];
					} else {
						$taxes[$tax_rate['tax_rate_id']] += $tax_rate['amount'];
					}
				}
			}
			
			$total += $this->session->data['shipping_method']['cost'];
		}			
	}

	public function getCheckoutTotal(&$total_data, &$total, &$taxes) {
		if(!isset($this->session->data['shipping_method'])){
			$quote_data = array();
			
			$this->load->model('setting/extension');
			
			$results = $this->model_setting_extension->getExtensions('shipping');
			
			foreach ($results as $result) {
				if ($this->config->get($result['code'] . '_status')) {
					$this->load->model('shipping/' . $result['code']);
					
					$quote = $this->{'model_shipping_' . $result['code']}->getQuote(array('province_id'=>0)); 
		
					if ($quote) {
						$quote_data[$result['code']] = array( 
							'title'      => $quote['title'],
							'quote'      => $quote['quote'], 
							'sort_order' => $quote['sort_order'],
							'error'      => $quote['error']
						);
						if(!isset($this->session->data['shipping_method']) || !$this->session->data['shipping_method']){
							$this->session->data['shipping_method'] = $quote['quote'][$result['code']];
						}
					}
				}
			}
		}
		if ($this->checkout->hasShipping() && isset($this->session->data['shipping_method'])) {
			$total_data[] = array( 
				'code'       => 'shipping',
        		'title'      => $this->session->data['shipping_method']['title'],
        		'text'       => $this->currency->format($this->session->data['shipping_method']['cost']),
        		'value'      => $this->session->data['shipping_method']['cost'],
				'sort_order' => $this->config->get('shipping_sort_order')
			);

			if ($this->session->data['shipping_method']['tax_class_id']) {
				$tax_rates = $this->tax->getRates($this->session->data['shipping_method']['cost'], $this->session->data['shipping_method']['tax_class_id']);
				
				foreach ($tax_rates as $tax_rate) {
					if (!isset($taxes[$tax_rate['tax_rate_id']])) {
						$taxes[$tax_rate['tax_rate_id']] = $tax_rate['amount'];
					} else {
						$taxes[$tax_rate['tax_rate_id']] += $tax_rate['amount'];
					}
				}
			}
			
			$total += $this->session->data['shipping_method']['cost'];
		}		
	}
}
