<?php
class ModelExtensionWiki extends Model {
	public function addWiki($data) {
		$fields = array(
			'title' => isset($data['title']) ? strip_tags(trim($data['title'])) : '',
			'subtitle' => isset($data['subtitle']) ? strip_tags(trim($data['subtitle'])) : '',
			'from' => isset($data['from']) ? strip_tags($data['from']) : '',
			'text' => isset($data['text']) ? htmlspecialchars_decode($data['text']) : '',
			'status' => isset($data['status']) ? (int)$data['status'] : 1,
			'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0,
			'group_id' => isset($data['group_id']) ? (int)$data['group_id'] : 0,
			'is_top' => isset($data['is_top']) ? (int)$data['is_top'] : 0,
			'user_id' => $this->user->getId(),
			'date_added' => date('Y-m-d H:i:s'),
		);

		return $this->db->insert("wiki",$fields);

	}
	
	public function editWiki($id, $data) {
		$fields = array(
			'title' => isset($data['title']) ? strip_tags(trim($data['title'])) : '',
			'subtitle' => isset($data['subtitle']) ? strip_tags(trim($data['subtitle'])) : '',
			'from' => isset($data['from']) ? strip_tags($data['from']) : '',
			'text' => isset($data['text']) ? htmlspecialchars_decode($data['text']) : '',
			'status' => isset($data['status']) ? (int)$data['status'] : 1,
			'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0,
			'group_id' => isset($data['group_id']) ? (int)$data['group_id'] : 0,
			'is_top' => isset($data['is_top']) ? (int)$data['is_top'] : 0,
			'user_id' => $this->user->getId(),
			'date_added' => date('Y-m-d H:i:s'),
		);

		return $this->db->update("wiki",array('wiki_id'=>$id),$fields);
	}
	
	public function getWiki($id) {
		$query = $this->db->query("SELECT *  FROM " . DB_PREFIX . "wiki WHERE wiki_id = '" . (int)$id . "'"); 
 
		if ($query->num_rows) {
			return $query->row;
		} else {
			return false;
		}
	}
   
	public function getAllWiki($data) {
		$sql = "SELECT * FROM " . DB_PREFIX . "wiki w LEFT JOIN " . DB_PREFIX . "wiki_group wg ON w.group_id = wg.group_id WHERE 1 ";
		if (!empty($data['tab'])) {
			$sql .= " AND w.group_id = '" . (int)$data['tab'] . "'";
		}		
		$sort_data = array(
			'w.title',
			'w.date_added',
			'w.sort_order'
		);	
		
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY w.date_added ";	
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
   
	public function deleteWiki($id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "wiki WHERE wiki_id = '" . (int)$id . "'");
	}
   
	public function countWiki($data=array()) {
		$sql = "SELECT COUNT(wiki_id) total FROM " . DB_PREFIX . "wiki";
		
		if (!empty($data['tab'])) {
			$sql .= " WHERE group_id = '" . (int)$data['tab'] . "'";
		}
		$query = $this->db->query($sql);
		return $query->row['total'];
	}
}