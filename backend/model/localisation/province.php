<?php
class ModelLocalisationProvince extends Model {
	public function addProvince($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "area SET status = '" . (int)$data['status'] . "', name = '" . $this->db->escape($data['name']) . "', sort = '" . $this->db->escape($data['sort']) . "',pid = '0'");
			
		$this->cache->delete('province');
	}
	
	public function editProvince($area_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "area SET status = '" . (int)$data['status'] . "', name = '" . $this->db->escape($data['name']) . "', sort = '" . $this->db->escape($data['sort']) . "',pid='0' WHERE area_id = '" . (int)$area_id . "'");

		$this->cache->delete('province');
	}
	
	public function deleteProvince($area_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "area WHERE area_id = '" . (int)$area_id . "'");

		$this->cache->delete('province');	
	}
	
	public function getProvince($area_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "area WHERE area_id = '" . (int)$area_id . "'");
		
		return $query->row;
	}
	
	public function getProvinces($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "area WHERE pid = '0'";
			
		$sort_data = array(
			'name',
			'sort'
		);	
			
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY sort";	
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
	

	
	public function getTotalProvinces() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "area WHERE pid = '0'");
		
		return $query->row['total'];
	}
				

}