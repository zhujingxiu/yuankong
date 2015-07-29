<?php
class ModelPaymentAlipayDirect extends Model {
	public function getMethod($total) {
		$this->load->language('payment/alipay_direct');

		if ($this->config->get('alipay_direct_status')) {
      		$status = TRUE;
      	} else {
			$status = FALSE;
		}
		
		$method_data = array();

		if ($status) {
			$method_data = array(
				'code'       => 'alipay_direct',
				'title'      => $this->language->get('text_title'),
				'terms'      => '',
				'sort_order' => $this->config->get('alipay_direct_sort_order'),
				'note' 		 => $this->config->get('alipay_direct_note')
			);
		}

		return $method_data;
	}
}