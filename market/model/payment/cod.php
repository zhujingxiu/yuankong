<?php 
class ModelPaymentCOD extends Model {
  	public function getMethod($total) {
		$this->language->load('payment/cod');
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "area_to_area_geo WHERE area_geo_id = '" . (int)$this->config->get('cod_area_geo_id') . "' AND (area_id = '" . (int)$address['area_id'] . "' OR area_id = '0')");
	
		if ($this->config->get('cod_total') > 0 && $this->config->get('cod_total') > $total) {
			$status = false;
		} elseif (!$this->config->get('cod_area_geo_id')) {
			$status = true;
		} elseif ($query->num_rows) {
			$status = true;
		} else {
			$status = false;
		}
		
		$method_data = array();
	
		if ($status) {  
      		$method_data = array( 
        		'code'       => 'cod',
        		'title'      => $this->language->get('text_title'),
				'sort_order' => $this->config->get('cod_sort_order')
      		);
    	}
   
    	return $method_data;
  	}
}