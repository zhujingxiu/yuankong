<?php
class ModelAccountHelp extends Model {	
	public function getHelps($data = array()) {
		$sql = "SELECT * FROM `" . DB_PREFIX . "help` WHERE customer_id = '" . (int)$this->customer->getId() . "'";
		   
		$sort_data = array(
			'customer_id',
			'telephone',
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
	public function getTotalHelps() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "help` WHERE customer_id = '" . (int)$this->customer->getId() . "'");
			
		return $query->row['total'];
	}
}
