<?php
class ModelCatalogInformation extends Model {
	public function getInformation($information_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) WHERE i.information_id = '" . (int)$information_id . "' AND id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i.status = '1'");
	
		return $query->row;
	}
	
	public function getInformations() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i.status = '1' ORDER BY i.sort_order, LCASE(id.title) ASC");
		
		return $query->rows;
	}
	
	public function getInformationLayoutId($information_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information_to_layout WHERE information_id = '" . (int)$information_id . "' AND store_id = '" . (int)$this->config->get('config_store_id') . "'");
		 
		if ($query->num_rows) {
			return $query->row['layout_id'];
		} else {
			return $this->config->get('config_layout_information');
		}
	}	

	public function getWiki($wiki_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "wiki w  LEFT JOIN " . DB_PREFIX . "wiki_group wg ON (w.group_id = wg.group_id) WHERE w.wiki_id = '" . (int)$wiki_id . "' AND w.status = '1'");
	
		return $query->row;
	}

	public function getWikiGroup($group_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "wiki_group  WHERE group_id = '" . (int)$group_id . "'");
	
		return $query->row;
	}

	public function getWikis($data=array()){

		$sql= "SELECT * FROM ".DB_PREFIX."wiki WHERE 1";
		if(isset($data['filter_group']) AND $data['filter_group']){
			$sql .= " AND group_id = '".(int)$data['filter_group']."'";
		}

		$sort_data = array(
			'viewed',
			'sort_order',
			'date_added'
		);
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY date_added";	
		}

		if (isset($data['order']) && ($data['order'] == 'ASC')) {
			$sql .= " ASC";
		} else {
			$sql .= " DESC";
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

	public function getTotalWiki($data=array()){
		$sql= "SELECT COUNT(wiki_id) total FROM ".DB_PREFIX."wiki WHERE 1";
		
		if(isset($data['filter_group']) AND $data['filter_group']){
			$sql .= " AND group_id = '".(int)$data['filter_group']."'";
		}

		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function addWikiViewed($wiki_id){
		if((int)$wiki_id){
			$this->db->query("UPDATE ".DB_PREFIX."wiki SET viewed = viewed + 1 WHERE wiki_id = '".(int)$wiki_id."'");
		}
	}
	public function getHelp($wiki_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "help WHERE help_id = '" . (int)$wiki_id . "' AND status = '1'");
	
		return $query->row;
	}
	public function getTotalHelp($data=array()){
		$sql= "SELECT COUNT(help_id) total FROM ".DB_PREFIX."help WHERE 1";
		

		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function getHelps($data=array()){
		$sql= "SELECT * FROM ".DB_PREFIX."help WHERE 1";

		$sort_data = array(
			'viewed',
			'sort_order',
			'date_added'
		);
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY sort_order";	
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
}