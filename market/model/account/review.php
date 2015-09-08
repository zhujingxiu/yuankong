<?php
class ModelAccountReview extends Model {	
	public function getReviews($data = array()) {
		$sql = "SELECT * FROM `" . DB_PREFIX . "review` WHERE customer_id = '" . (int)$this->customer->getId() . "'";
		   
		$sort_data = array(
			'product_id',
			'rating',
			'date_added'
		);
	
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY date_added";	
		}
			
		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}
		
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}			

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}	
			
			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);
	
		return $query->rows;
	}	
		
	public function getTotalReviews() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "review` WHERE customer_id = '" . (int)$this->customer->getId() . "'");
			
		return $query->row['total'];
	}	
			
	public function getUnreviewedOrders(){
		$reviewed = array();
		$query = $this->db->query("SELECT order_id FROM ".DB_PREFIX."review WHERE customer_id = '".$this->customer->getId()."' ");
		if($query->num_rows){
			foreach ($query->rows as $order) {
				if($order){
					$reviewed[] = $order;
				}
			}
		}
		$unreview = array();
		$query = $this->db->query("SELECT order_id FROM ".DB_PREFIX."order WHERE customer_id = '".$this->customer->getId()."' AND order_status_id > '".(int)$this->config->get('config_received_status_id')."' AND order_id NOT IN (".implode(",", $reviewed).")");
		if($query->num_rows){
			foreach ($query->rows as $order) {
				if($order){
					$unreview[] = $order;
				}
			}
		}

		return $unreview;
	}

	public function addReview($product_id, $data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "review SET author = '" . $this->db->escape($data['name']) . "', customer_id = '" . (int)$this->customer->getId() . "', product_id = '" . (int)$product_id . "', text = '" . $this->db->escape($data['text']) . "', rating = '" . (int)$data['rating'] . "', date_added = NOW()".(isset($data['order_id']) ? ",order_id = '".(int)$data['order_id']."'" : ''));
	}
}
