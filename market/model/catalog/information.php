<?php
class ModelCatalogInformation extends Model {
	public function getInformation($information_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) LEFT JOIN " . DB_PREFIX . "information_to_store i2s ON (i.information_id = i2s.information_id) WHERE i.information_id = '" . (int)$information_id . "' AND id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1'");
	
		return $query->row;
	}
	
	public function getInformations() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) LEFT JOIN " . DB_PREFIX . "information_to_store i2s ON (i.information_id = i2s.information_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND i.status = '1' ORDER BY i.sort_order, LCASE(id.title) ASC");
		
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
		if(isset($data['filter_group'])){
			$sql .= " AND group_id = '".(int)$data['filter_group']."'";
		}

		$sort_data = array(
			'viewed',
			'sort_order',
			'date_added'
		);
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			
		} else {
			$sql .= " ORDER BY p.sort_order";	
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
		
		if(isset($data['filter_group'])){
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
}