<?php 
class ModelPaymentBankTransfer extends Model {
  	public function getMethod($total) {
		$this->language->load('payment/bank_transfer');
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "area_to_area_geo WHERE area_geo_id = '" . (int)$this->config->get('bank_transfer_area_geo_id') . "' AND (area_id = '" . (int)$address['area_id'] . "' OR area_id = '0')");
		
		if ($this->config->get('bank_transfer_total') > 0 && $this->config->get('bank_transfer_total') > $total) {
			$status = false;
		} elseif (!$this->config->get('bank_transfer_area_geo_id')) {
			$status = true;
		} elseif ($query->num_rows) {
			$status = true;
		} else {
			$status = false;
		}	
		
		$method_data = array();
	
		if ($status) {  
      		$method_data = array( 
        		'code'       => 'bank_transfer',
        		'title'      => $this->language->get('text_title'),
				'sort_order' => $this->config->get('bank_transfer_sort_order')
      		);
    	}
   
    	return $method_data;
  	}
}
