<?php 
class ModelSaleProjectGroup extends Model {
	public function addProjectGroup($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "project_group SET sort_order = '" . (int)$data['sort_order'] . "'");
		
		$project_group_id = $this->db->getLastId();
		
		foreach ($data['project_group_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "project_group_description SET project_group_id = '" . (int)$project_group_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "'");
		}
	}

	public function editProjectGroup($project_group_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "project_group SET sort_order = '" . (int)$data['sort_order'] . "' WHERE project_group_id = '" . (int)$project_group_id . "'");
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "project_group_description WHERE project_group_id = '" . (int)$project_group_id . "'");

		foreach ($data['project_group_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "project_group_description SET project_group_id = '" . (int)$project_group_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "'");
		}
	}
	
	public function deleteProjectGroup($project_group_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "project_group WHERE project_group_id = '" . (int)$project_group_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "project_group_description WHERE project_group_id = '" . (int)$project_group_id . "'");
	}
		
	public function getProjectGroup($project_group_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "project_group WHERE project_group_id = '" . (int)$project_group_id . "'");
		
		return $query->row;
	}
		
	public function getProjectGroups($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "project_group ag LEFT JOIN " . DB_PREFIX . "project_group_description agd ON (ag.project_group_id = agd.project_group_id) WHERE agd.language_id = '" . (int)$this->config->get('config_language_id') . "'";
			
		$sort_data = array(
			'agd.name',
			'ag.sort_order'
		);	
		
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY agd.name";	
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
	
	public function getProjectGroupDescriptions($project_group_id) {
		$project_group_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "project_group_description WHERE project_group_id = '" . (int)$project_group_id . "'");
		
		foreach ($query->rows as $result) {
			$project_group_data[$result['language_id']] = array('name' => $result['name']);
		}
		
		return $project_group_data;
	}
	
	public function getTotalProjectGroups() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "project_group");
		
		return $query->row['total'];
	}	
}
