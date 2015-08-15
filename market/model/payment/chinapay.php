<?php 
class ModelPaymentChinapay extends Model {
	public function getMethod($address, $total) {
		$this->load->language('payment/chinapay');

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "area_to_area_geo WHERE area_geo_id = '" . (int)$this->config->get('bank_transfer_area_geo_id') . "' AND (area_id = '" . (int)$address['area_id'] . "' OR area_id = '0')");

		if ($this->config->get('chinapay_total') > $total) {
			$status = false;
		} elseif (!$this->config->get('chinapay_area_geo_id')) {
			$status = true;
		} elseif ($query->num_rows) {
			$status = true;
		} else {
			$status = false;
		}	

		$currencies = array(
			'CHY',
			'CNY',
			'HKD',
			'USD'
		);

		if (!in_array(strtoupper($this->currency->getCode()), $currencies)) {
			$status = false;
		}			

		$method_data = array();

		if ($status) {  
			$method_data = array(
				'code'       => 'chinapay',
				'title'      => $this->language->get('text_title'),
				'terms'      => '',
				'sort_order' => $this->config->get('chinapay_sort_order')
			);
		}

		return $method_data;
	}
}
