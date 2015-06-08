<?php
class ModelCatalogHelp extends Model {
	public function addHelp($datas) {
		$insert_data = array();
		foreach ($datas as $key => $items){
			if(is_array($items)){
				foreach ($items as $language => $item){
					$insert_data[$language][$key] = $item;
				}
			}
		}
		if($insert_data){
			$help_id = 0;
			foreach ($insert_data as $language_id=> $data ){
				if(!$help_id){
					$this->db->query("INSERT INTO " . DB_PREFIX . "help SET title = '".$this->db->escape(strip_tags($data['title']))."', text = '" . $this->db->escape(strip_tags($data['text'])) . "', status = '" . (int)$data['status'] . "', is_top = '" . (int)$data['is_top'] . "', sort_order = '".(int)$data['sort_order']."', date_added = NOW()");
					$help_id = $this->db->getLastId();
					$this->db->query("DELETE FROM " . DB_PREFIX . "help WHERE help_id = '" . (int)$help_id . "' ");
				}
				$this->db->query("INSERT INTO " . DB_PREFIX . "help SET help_id = '" . (int)$help_id . "', language_id = '".(int)$language_id."' , title = '".$this->db->escape(strip_tags($data['title']))."', text = '" . $this->db->escape(strip_tags($data['text'])) . "', status = '" . (int)$data['status'] . "',is_top = '" . (int)$data['is_top'] . "',sort_order = '".(int)$data['sort_order']."' ,date_added = NOW()");
			}
		}
	}
	
	public function editHelp($help_id, $datas) {
		$update_data = array();
		foreach ($datas as $key => $items){
			if(is_array($items)){
				foreach ($items as $language => $item){
					$update_data[$language][$key] = $item;
				}
			}
		}
		if($update_data){
			$this->db->query("DELETE FROM " . DB_PREFIX . "help WHERE help_id = '" . (int)$help_id . "' ");
			foreach ($update_data as $language_id=> $data ){
				$this->db->query("INSERT INTO " . DB_PREFIX . "help SET help_id = '" . (int)$help_id . "', language_id = '".(int)$language_id."' , title = '".$this->db->escape(strip_tags($data['title']))."', text = '" . $this->db->escape(strip_tags($data['text'])) . "', status = '" . (int)$data['status'] . "',is_top = '" . (int)$data['is_top'] . "',sort_order = '".(int)$data['sort_order']."' ,date_added = NOW()");
			}
		}
	}
	
	public function deleteHelp($help_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "help WHERE help_id = '" . (int)$help_id . "'");
		
	}
	
	public function getHelp($help_id) {
		$data = array();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "help f WHERE f.help_id = '" . (int)$help_id . "'");
		if($query->num_rows){
			foreach ($query->rows as $row){
				$data[$row['language_id']] = $row;
			}
		}
		return $data;
	}

	public function getHelps($data = array()) {
		$sql = "SELECT f.* FROM " . DB_PREFIX . "help f WHERE language_id = '".(int)$this->config->get('config_language_id')."' " ;																																					  
		
		$sort_data = array(
			'f.status',
			'f.is_top',
			'f.date_added'
		);	
			
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY f.date_added";	
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
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "help");
		
		return $query->row['total'];
	}
	
}