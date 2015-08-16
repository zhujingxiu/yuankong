<?php 
class ModelExtensionExpress extends Model {
	public function addExpress($data) {
		$fields = array(
			'title' 	=> isset($data['title']) ? strip_tags(trim($data['title'])) : '',
			'logo' 		=> isset($data['logo']) ? htmlspecialchars_decode($data['logo']) : '',
			'telephone' => isset($data['telephone']) ? $data['telephone'] : '',
			'note' 		=> isset($data['note']) ? strip_tags(trim($data['note'])) : '',
			'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0,
			'date_added' => date('Y-m-d H:i:s')
		);

		return $this->db->insert("express",$fields);
	}

	public function editExpress($express_id, $data) {
		$fields = array(
			'title' 	=> isset($data['title']) ? strip_tags(trim($data['title'])) : 0,
			'note' 		=> isset($data['note']) ? strip_tags(trim($data['note'])) : '',
			'telephone' => isset($data['telephone']) ? $data['telephone'] : '',
			'logo' 		=> isset($data['logo']) ? htmlspecialchars_decode($data['logo']) : '',
			'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0,
			'date_added' => date('Y-m-d H:i:s')
		);

		return $this->db->update("express",array('express_id'=>$express_id),$fields);
	}
	
	public function deleteExpress($express_id) {
		$this->db->delete("express",array('express_id' => (int)$express_id));
	}
		
	public function getExpress($express_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "express WHERE express_id = '" . (int)$express_id . "'");
		
		return $query->row;
	}
		
	public function getExpresss($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "express ";
			
		$sort_data = array(
			'title',
			'telephone',
			'sort_order',
			'date_added'
		);	
		
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY express_id";	
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
	
	
	public function getTotalExpresss() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "express");
		
		return $query->row['total'];
	}	
}
