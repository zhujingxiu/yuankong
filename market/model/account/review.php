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
			
	public function getUnreviewOrderProducts($data=array()){
		$reviewed = array();
		$query = $this->db->query("SELECT order_id,product_id FROM ".DB_PREFIX."review WHERE customer_id = '".$this->customer->getId()."' ");
		if($query->num_rows){
			foreach ($query->rows as $order) {
				if($order){
					$reviewed['order'][] = $order['order_id'];
					$reviewed['product'][] = $order['product_id'];
				}
			}
		}

		$where=array();
		$where[] = "o.customer_id = '" .$this->customer->getId()."'";
		$where[] = "o.order_status_id > '" .(int)$this->config->get('config_received_status_id')."'";
		if(isset($reviewed['order'])){
			$where[] = "o.order_id NOT IN (".implode(",", $reviewed['order']).")";
		}
		$sql = "SELECT op.*,o.date_modified order_date FROM ".DB_PREFIX."order_product op LEFT JOIN ".DB_PREFIX."order o ON o.order_id = op.order_id WHERE ".implode(" AND ", $where)." ORDER BY o.date_modified DESC ";

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

	public function addReview($data) {
		$field = array(
			'author' => $this->customer->getFullName(),
			'customer_id' => $this->customer->getId(),
			'product_id' => $data['product_id'],
			'order_id' => $data['order_id'],
			'text' => strip_tags($data['text']),
			'rating' => (int)$data['rating'],
			'shipping' => (int)$data['shipping'],
			'service' => (int)$data['service'],
			'date_added' => date('Y-m-d H:i:s')
		);
		$this->db->insert("review",$field);
	}

	public function getReview($order_id,$product_id){
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."review WHERE customer_id = '".$this->customer->getId()."' AND order_id = '".(int)$order_id."' AND product_id = '".(int)$product_id."'");
		return $query->row;
	}

	public function getOrderAndProduct($order_id,$product_id){
		$query = $this->db->query("SELECT op.* FROM " . DB_PREFIX . "order_product op LEFT JOIN ".DB_PREFIX."product p ON op.product_id = p.product_id LEFT JOIN ".DB_PREFIX."order o ON o.order_id = op.order_id WHERE o.customer_id = '".$this->customer->getId()."' AND op.order_id = '" . (int)$order_id . "' AND op.product_id = '".(int)$product_id."'");
	
		return $query->row;
	}

	public function delete($review_id){
		$this->db->delete('review',array('customer_id'=>$this->customer->getId(),'review_id'=>$review_id));
	}
}
