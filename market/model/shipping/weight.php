<?php 
class ModelShippingWeight extends Model {    
  	public function getQuote($address) {
		$this->language->load('shipping/weight');
		
		$quote_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "area_geo ORDER BY name");
	
		foreach ($query->rows as $result) {
			if ($this->config->get('weight_' . $result['area_geo_id'] . '_status')) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "area_to_area_geo WHERE area_geo_id = '" . (int)$result['area_geo_id'] . "' AND  (area_id = '" . (int)$address['province_id'] . "' OR area_id = '0')");
			
				if ($query->num_rows) {
					$status = true;
				} else {
					$status = false;
				}
			} else {
				$status = false;
			}
		
			if ($status) {
				$cost = '';
				$weight = $this->checkout->getWeight();
				
				$rates = explode(',', $this->config->get('weight_' . $result['area_geo_id'] . '_rate'));
				
				foreach ($rates as $rate) {
					$data = explode(':', $rate);
				
					if ($data[0] >= $weight) {
						if (isset($data[1])) {
							$cost = $data[1];
						}
				
						break;
					}
				}
				
				if ((string)$cost != '') { 
					$quote_data['weight_' . $result['area_geo_id']] = array(
						'code'         => 'weight.weight_' . $result['area_geo_id'],
						'title'        => $result['name'] . '  (' . $this->language->get('text_weight') . ' ' . $this->weight->format($weight, $this->config->get('config_weight_class_id')) . ')',
						'cost'         => $cost,
						'tax_class_id' => $this->config->get('weight_tax_class_id'),
						'text'         => $this->currency->format($this->tax->calculate($cost, $this->config->get('weight_tax_class_id'), $this->config->get('config_tax')))
					);	
				}
			}
		}
		
		$method_data = array();
	
		if ($quote_data) {
      		$method_data = array(
        		'code'       => 'weight',
        		'title'      => $this->language->get('text_title'),
        		'quote'      => $quote_data,
				'sort_order' => $this->config->get('weight_sort_order'),
        		'error'      => false
      		);
		}
	
		return $method_data;
  	}
}
