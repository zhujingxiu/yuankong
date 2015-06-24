<?php 
class ModelExtensionWikiGroup extends Model {
	public function addWikiGroup($data) {
		$fields = array(
			'name' => isset($data['name']) ? strip_tags(trim($data['name'])) : '',
			'tag' => isset($data['tag']) ? (int)$data['tag'] : 1,
			'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0
		);

		return $this->db->insert("wiki_group",$fields);
	}

	public function editWikiGroup($wiki_group_id, $data) {
		$fields = array(
			'name' => isset($data['name']) ? strip_tags(trim($data['name'])) : 0,
			'tag' => isset($data['tag']) ? (int)$data['tag'] : 1,
			'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0
		);

		return $this->db->update("wiki_group",array('group_id'=>$wiki_group_id),$fields);
	}
	
	public function deleteWikiGroup($wiki_group_id) {
		$this->db->delete("wiki_group",array('group_id' => (int)$wiki_group_id));
	}
		
	public function getWikiGroup($wiki_group_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "wiki_group WHERE group_id = '" . (int)$wiki_group_id . "'");
		
		return $query->row;
	}
		
	public function getWikiGroups($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "wiki_group ";
			
		$sort_data = array(
			'name',
			'tag',
			'sort_order'
		);	
		
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY group_id";	
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
	
	
	public function getTotalWikiGroups() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "wiki_group");
		
		return $query->row['total'];
	}	
}
