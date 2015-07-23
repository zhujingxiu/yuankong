<?php
class ModelShippingItem extends Model {
	function getQuote($address) {
		$this->language->load('shipping/item');
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "area_to_area_geo WHERE area_geo_id = '" . (int)$this->config->get('item_geo_zone_id') . "' AND (area_id = '" . (int)$address['province_id'] . "' OR area_id = '0')");
		
		if (!$this->config->get('item_area_geo_id')) {
			$status = true;
		} elseif ($query->num_rows) {
			$status = true;
		} else {
			$status = false;
		}
		
		$method_data = array();
	
		if ($status) {
			$items = 0;
			
			foreach ($this->checkout->getProducts() as $product) {
				if ($product['shipping']) $items += $product['quantity'];
			}			
			
			$quote_data = array();
			
      		$quote_data['item'] = array(
        		'code'         => 'item.item',
        		'title'        => $this->language->get('text_description'),
        		'cost'         => $this->config->get('item_cost') * $items,
         		'tax_class_id' => $this->config->get('item_tax_class_id'),
				'text'         => $this->currency->format($this->tax->calculate($this->config->get('item_cost') * $items, $this->config->get('item_tax_class_id'), $this->config->get('config_tax')))
      		);

      		$method_data = array(
        		'code'       => 'item',
        		'title'      => $this->language->get('text_title'),
        		'quote'      => $quote_data,
				'sort_order' => $this->config->get('item_sort_order'),
        		'error'      => false
      		);
		}
	
		return $method_data;
	}
}
