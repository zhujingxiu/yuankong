<?php
class ModelLocalisationAreaGeo extends Model {
	public function addAreaGeo($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "area_geo SET name = '" . $this->db->escape($data['name']) . "', description = '" . $this->db->escape($data['description']) . "', date_added = NOW()");

		$area_geo_id = $this->db->getLastId();
		
		if (isset($data['area_to_area_geo'])) {
			foreach ($data['area_to_area_geo'] as $value) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "area_to_area_geo SET  area_id = '"  . (int)$value['area_id'] . "', area_geo_id = '"  .(int)$area_geo_id . "', date_added = NOW()");
			}
		}
		
		$this->cache->delete('area_geo');
	}
	
	public function editAreaGeo($area_geo_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "area_geo SET name = '" . $this->db->escape($data['name']) . "', description = '" . $this->db->escape($data['description']) . "', date_added = NOW() WHERE area_geo_id = '" . (int)$area_geo_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "area_to_area_geo WHERE area_geo_id = '" . (int)$area_geo_id . "'");
		
		if (isset($data['area_to_area_geo'])) {
			foreach ($data['area_to_area_geo'] as $value) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "area_to_area_geo SET  area_id = '"  . (int)$value['area_id'] . "', area_geo_id = '"  .(int)$area_geo_id . "', date_added = NOW()");
			}
		}
		
		$this->cache->delete('area_geo');
	}
	
	public function deleteAreaGeo($area_geo_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "area_geo WHERE area_geo_id = '" . (int)$area_geo_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "area_to_area_geo WHERE area_geo_id = '" . (int)$area_geo_id . "'");

		$this->cache->delete('area_geo');
	}
	
	public function getAreaGeo($area_geo_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "area_geo WHERE area_geo_id = '" . (int)$area_geo_id . "'");
		
		return $query->row;
	}

	public function getAreaGeos($data = array()) {
		if ($data) {
			$sql = "SELECT * FROM " . DB_PREFIX . "area_geo";
	
			$sort_data = array(
				'name',
				'description'
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
		} else {
			$area_geo_data = $this->cache->get('area_geo');

			if (!$area_geo_data) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "area_geo ORDER BY name ASC");
	
				$area_geo_data = $query->rows;
			
				$this->cache->set('area_geo', $area_geo_data);
			}
			
			return $area_geo_data;				
		}
	}
	
	public function getTotalAreaGeos() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "area_geo");
		
		return $query->row['total'];
	}	
	
	public function getAreaToAreaGeos($area_geo_id) {	
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "area_to_area_geo WHERE area_geo_id = '" . (int)$area_geo_id . "'");
		
		return $query->rows;	
	}		

	public function getTotalAreaToAreaGeoByAreaGeoId($area_geo_id) {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "area_to_area_geo WHERE area_geo_id = '" . (int)$area_geo_id . "'");
		
		return $query->row['total'];
	}
	
	public function getTotalAreaToAreaGeoByAreaId($area_id) {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "area_to_area_geo WHERE area_id = '" . (int)$area_id . "'");
		
		return $query->row['total'];
	}		
}
