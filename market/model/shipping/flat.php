<?php
class ModelShippingFlat extends Model {
	function getQuote($address) {

		$this->language->load('shipping/flat');
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "area_to_area_geo WHERE area_geo_id = '" . (int)$this->config->get('flat_area_geo_id') . "' AND (area_id = '" . (int)$address['province_id'] . "' OR area_id = '0')");
	
		if (!$this->config->get('flat_area_geo_id')) {
			$status = true;
		} elseif ($query->num_rows) {
			$status = true;
		} else {
			$status = false;
		}

		$method_data = array();
	
		if ($status) {
			$quote_data = array();
			
      		$quote_data['flat'] = array(
        		'code'         => 'flat.flat',
        		'title'        => $this->language->get('text_description'),
        		'cost'         => $this->config->get('flat_cost'),
        		'tax_class_id' => $this->config->get('flat_tax_class_id'),
				'text'         => $this->currency->format($this->tax->calculate($this->config->get('flat_cost'), $this->config->get('flat_tax_class_id'), $this->config->get('config_tax')))
      		);

      		$method_data = array(
        		'code'       => 'flat',
        		'title'      => $this->language->get('text_title'),
        		'quote'      => $quote_data,
				'sort_order' => $this->config->get('flat_sort_order'),
        		'error'      => false
      		);
		}

		return $method_data;
	}
}
