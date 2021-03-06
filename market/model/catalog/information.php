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

	public function getHelpCenterInformations(){
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) WHERE i.center = 1 AND id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i.status = '1' ORDER BY i.sort_order, i.information_id DESC");
		
		return $query->rows;
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
		if(isset($data['filter_group']) && $data['filter_group']){
			$sql .= " AND group_id = '".(int)$data['filter_group']."'";
		}
		if(isset($data['filter_search']) && trim($data['filter_search'])){
			$sql .= " AND (title LIKE '%".$this->db->escape(trim($data['filter_search']))."%' OR `text` LIKE '%".$this->db->escape(trim($data['filter_search']))."%')";
		}
		switch (strtolower($data['sort'])) {
			case 'viewed':
				$sql .= " ORDER BY viewed DESC,date_added DESC";
				break;
			default:
				$sql .= " ORDER BY sort_order ASC,date_added DESC";
				break;
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
		if(isset($data['filter_search']) && trim($data['filter_search'])){
			$sql .= " AND (`title` LIKE '%".$this->db->escape(trim($data['filter_search']))."%' OR `text` LIKE '%".$this->db->escape(trim($data['filter_search']))."%')";
		}
		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function addWikiViewed($wiki_id){
		if((int)$wiki_id){
			$this->db->query("UPDATE ".DB_PREFIX."wiki SET viewed = viewed + 1 WHERE wiki_id = '".(int)$wiki_id."'");
		}
	}
	public function AddHelp($data) {
		$fields = array(
			'customer_id' 	=> $this->customer->getId(),
			'account' 		=> $this->customer->getFullName(),
			'telephone' 	=> $this->customer->getMobilePhone(),
			'text'			=> strip_tags($data['text']),
			'status'		=> 1,
			'date_added'	=> date('Y-m-d H:i:s')
		);
		return $this->db->insert("help",$fields);
	}	
	public function addHelpViewed($help_id){
		if((int)$help_id){
			$this->db->query("UPDATE ".DB_PREFIX."help SET viewed = viewed + 1 WHERE help_id = '".(int)$help_id."'");
		}
	}
	public function getHelp($wiki_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "help WHERE help_id = '" . (int)$wiki_id . "' AND status = '1'");
	
		return $query->row;
	}
	public function getTotalHelp($data=array()){
		$sql= "SELECT COUNT(help_id) total FROM ".DB_PREFIX."help WHERE LENGTH(reply) > 0 ";
		
		if(isset($data['filter_search']) && trim($data['filter_search'])){
			$sql .= " AND (`text` LIKE '%".$this->db->escape(trim($data['filter_search']))."%' OR `reply` LIKE '%".$this->db->escape(trim($data['filter_search']))."%')";
		}
		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function getHelps($data=array()){
		$sql= "SELECT * FROM ".DB_PREFIX."help WHERE LENGTH(reply) > 0 ";

		if(isset($data['filter_search']) && trim($data['filter_search'])){
			$sql .= " AND (`text` LIKE '%".$this->db->escape(trim($data['filter_search']))."%' OR `reply` LIKE '%".$this->db->escape(trim($data['filter_search']))."%')";
		}
		switch (strtolower(trim($data['sort']))) {
			case 'viewed':
				$sql .= " ORDER BY viewed DESC,date_added DESC";
				break;
			default:
				$sql .= " ORDER BY sort_order ASC,date_added DESC";
				break;
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

	public function getTopHelps($limit=5){
		$sql= "SELECT * FROM ".DB_PREFIX."help WHERE LENGTH(reply) >5 AND user_id > 0 ORDER BY is_top DESC ,date_replied DESC,date_added DESC LIMIT ".$limit;
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getRelateds($tag){
		$data = array();
		$tag = trim($tag);
		$tags = strlen($tag) ? explode(";", $tag) : false;
		if(is_array($tags)){
			foreach ($tags as $value) {
				if(empty($value)){
					continue;
				}
				$query = $this->db->query("SELECT * FROM ".DB_PREFIX."help WHERE tag LIKE '%".$this->db->escape($value)."%'");
				if($query->num_rows){
					$data = array_merge($query->rows,$data);
				}
			}
		}
		if(count($data)<3){
			$query = $this->db->query("SELECT * FROM ".DB_PREFIX."help WHERE LENGTH(reply) > 4 ORDER BY is_top DESC, viewed DESC ,date_replied DESC LIMIT 5");
			if($query->num_rows){
				$data = array_merge($query->rows,$data);
			}
		}
		return $data;
	}
}