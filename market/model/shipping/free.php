<?php
class ModelShippingFree extends Model {
	function getQuote($address) {
		$this->language->load('shipping/free');
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "area_to_area_geo WHERE area_geo_id = '" . (int)$this->config->get('free_geo_zone_id') . "' AND (area_id = '" . (int)$address['province_id'] . "' OR area_id = '0')");
	
		if (!$this->config->get('free_area_geo_id')) {
			$status = true;
		} elseif ($query->num_rows) {
			$status = true;
		} else {
			$status = false;
		}

		if ($this->checkout->getSubTotal() < $this->config->get('free_total')) {
			$status = false;
		}
		
		$method_data = array();
	
		if ($status) {
			$quote_data = array();
			
      		$quote_data['free'] = array(
        		'code'         => 'free.free',
        		'title'        => $this->language->get('text_description'),
        		'cost'         => 0.00,
        		'tax_class_id' => 0,
				'text'         => $this->currency->format(0.00)
      		);

      		$method_data = array(
        		'code'       => 'free',
        		'title'      => $this->language->get('text_title'),
        		'quote'      => $quote_data,
				'sort_order' => $this->config->get('free_sort_order'),
        		'error'      => false
      		);
		}
	
		return $method_data;
	}
}
?>