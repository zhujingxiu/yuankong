<?php
class ModelCatalogNews extends Model {
	public function addNews($datas) {
		$insert_data = array();
		foreach ($datas as $key => $items){
			if(is_array($items)){
				foreach ($items as $language => $item){
					$insert_data[$language][$key] = $item;
				}
			}
		}
		if($insert_data){
			$news_id = 0;
			foreach ($insert_data as $language_id=> $data ){
				if(empty($data['date_added'])){
					$data['date_added'] = date('Y-m-d H:i:s');
				}
				if(!$news_id){
					$this->db->query("INSERT INTO " . DB_PREFIX . "news SET user_id = '" . (int)$this->user->getId() . "', title = '".$this->db->escape(strip_tags($data['title']))."', text = '" . $this->db->escape(strip_tags($data['text'])) . "', status = '" . (int)$data['status'] . "', sort_order = '".(int)$data['sort_order']."', date_added = '".$data['date_added']."'");
					$news_id = $this->db->getLastId();
					$this->db->query("DELETE FROM " . DB_PREFIX . "news WHERE news_id = '" . (int)$news_id . "' ");
				}
				$this->db->query("INSERT INTO " . DB_PREFIX . "news SET user_id = '" . (int)$this->user->getId() . "',news_id = '" . (int)$news_id . "', language_id = '".(int)$language_id."' , title = '".$this->db->escape(strip_tags($data['title']))."', text = '" . $this->db->escape(strip_tags($data['text'])) . "', status = '" . (int)$data['status'] . "',sort_order = '".(int)$data['sort_order']."' ,date_added = '".$this->db->escape($data['date_added'])."'");
			}
		}
	}
	
	public function editNews($news_id, $datas) {
		
		$update_data = array();
		foreach ($datas as $key => $items){
			if(is_array($items)){
				foreach ($items as $language => $item){
					$update_data[$language][$key] = $item;
				}
			}
		}

		if($update_data){
			$this->db->query("DELETE FROM " . DB_PREFIX . "news WHERE news_id = '" . (int)$news_id . "' ");
			foreach ($update_data as $language_id=> $data ){
				$this->db->query("INSERT INTO " . DB_PREFIX . "news SET user_id = '" . (int)$this->user->getId() . "', news_id = '" . (int)$news_id . "', language_id = '".(int)$language_id."' , title = '".$this->db->escape(strip_tags($data['title']))."', text = '" . $this->db->escape(strip_tags($data['text'])) . "', status = '" . (int)$data['status'] . "', sort_order = '".(int)$data['sort_order']."' ,date_added = '".$this->db->escape($data['date_added'])."'");
			}
		}
	}
	
	public function deleteNews($news_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "news WHERE news_id = '" . (int)$news_id . "'");

	}
	
	public function getNews($news_id) {
		$data = array();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "news n WHERE n.news_id = '" . (int)$news_id . "'");
		
		if($query->num_rows){
			foreach ($query->rows as $row){
				$data[$row['language_id']] = $row;
			}
		}
		return $data;
	}

	public function getNewses($data = array()) {
		$sql = "SELECT n.*, u.username as user FROM " . DB_PREFIX . "news n LEFT JOIN ".DB_PREFIX."user u on n.user_id = u.user_id WHERE n.language_id = '".(int)$this->config->get('config_language_id')."'";																																					  
		
		$sort_data = array(
			'u.username',
			'n.status',
			'n.date_added'
		);	
			
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY n.date_added";	
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
	
	public function getTotalNewses() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "news WHERE language_id = '".(int)$this->config->get('config_language_id')."'");
		
		return $query->row['total'];
	}
	
}