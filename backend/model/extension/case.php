<?php
class ModelExtensionCase extends Model {
	public function addCase($data) {
      	$this->db->query("INSERT INTO " . DB_PREFIX . "case SET `name` = '" . $this->db->escape($data['name']) . "', `cover` = '" . $this->db->escape(html_entity_decode($data['cover'], ENT_QUOTES, 'UTF-8')) . "', sort_order = '" . (int)$data['sort_order'] . "'");
		
		return $this->db->getLastId();
	}
	
	public function editCase($case_id, $data) {

      	$this->db->query("UPDATE " . DB_PREFIX . "case SET `name` = '" . $this->db->escape($data['name']) . "', `cover` = '" . $this->db->escape(html_entity_decode($data['cover'], ENT_QUOTES, 'UTF-8')) . "',sort_order = '" . (int)$data['sort_order'] . "' WHERE case_id = '" . (int)$case_id . "'");
	}
	
	public function deleteCase($case_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "case WHERE case_id = '" . (int)$case_id . "'");
			
	}	
	
	public function getCase($case_id) {
		$query = $this->db->query("SELECT DISTINCT *  FROM " . DB_PREFIX . "case WHERE case_id = '" . (int)$case_id . "'");
		
		return $query->row;
	}
	
	public function getCases($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "case";

		if (!empty($data['filter_name'])) {
			$sql .= " WHERE name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}
		
		$sort_data = array(
			'name',
			'sort_order'
		);	
		
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY name";	
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

	public function getTotalCases() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "case");
		
		return $query->row['total'];
	}	
}