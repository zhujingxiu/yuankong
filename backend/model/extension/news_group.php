<?php 
class ModelExtensionNewsGroup extends Model {
	public function addNewsGroup($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "news_group SET sort_order = '" . (int)$data['sort_order'] . "'");
		
		$news_group_id = $this->db->getLastId();
		
		foreach ($data['news_group_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "news_group_description SET news_group_id = '" . (int)$news_group_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "'");
		}
	}

	public function editNewsGroup($news_group_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "news_group SET sort_order = '" . (int)$data['sort_order'] . "' WHERE news_group_id = '" . (int)$news_group_id . "'");
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "news_group_description WHERE news_group_id = '" . (int)$news_group_id . "'");

		foreach ($data['news_group_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "news_group_description SET news_group_id = '" . (int)$news_group_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "'");
		}
	}
	
	public function deleteNewsGroup($news_group_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "news_group WHERE news_group_id = '" . (int)$news_group_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "news_group_description WHERE news_group_id = '" . (int)$news_group_id . "'");
	}
		
	public function getNewsGroup($news_group_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "news_group WHERE news_group_id = '" . (int)$news_group_id . "'");
		
		return $query->row;
	}
		
	public function getNewsGroups($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "news_group ag LEFT JOIN " . DB_PREFIX . "news_group_description agd ON (ag.news_group_id = agd.news_group_id) WHERE agd.language_id = '" . (int)$this->config->get('config_language_id') . "'";
			
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
	
	public function getNewsGroupDescriptions($news_group_id) {
		$news_group_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "news_group_description WHERE news_group_id = '" . (int)$news_group_id . "'");
		
		foreach ($query->rows as $result) {
			$news_group_data[$result['language_id']] = array('name' => $result['name']);
		}
		
		return $news_group_data;
	}
	
	public function getTotalNewsGroups() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "news_group");
		
		return $query->row['total'];
	}	
}
