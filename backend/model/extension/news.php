<?php
class ModelExtensionNews extends Model {
	public function addNews($data) {
		$fields = array(
			'title' => isset($data['title']) ? strip_tags(trim($data['title'])) : '',
			'subtitle' => isset($data['subtitle']) ? strip_tags(trim($data['subtitle'])) : '',
			'from' => isset($data['from']) ? strip_tags($data['from']) : '',
			'text' => isset($data['text']) ? htmlspecialchars_decode($data['text']) : '',
			'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0,
			'group_id' => isset($data['group_id']) ? (int)$data['group_id'] : 0,
			'is_top' => isset($data['is_top']) ? (int)$data['is_top'] : 0,
			'user_id' => $this->user->getId(),
			'date_added' => date('Y-m-d H:i:s'),
		);

		return $this->db->insert("news",$fields);

	}
	
	public function editNews($id, $data) {
		$fields = array(
			'title' => isset($data['title']) ? strip_tags(trim($data['title'])) : '',
			'subtitle' => isset($data['subtitle']) ? strip_tags(trim($data['subtitle'])) : '',
			'from' => isset($data['from']) ? strip_tags($data['from']) : '',
			'text' => isset($data['text']) ? htmlspecialchars_decode($data['text']) : '',
			'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0,
			'group_id' => isset($data['group_id']) ? (int)$data['group_id'] : 0,
			'is_top' => isset($data['is_top']) ? (int)$data['is_top'] : 0,
			'user_id' => $this->user->getId(),
			'date_added' => date('Y-m-d H:i:s'),
		);

		return $this->db->update("news",array('news_id'=>$id),$fields);
	}
	
	public function getNews($id) {
		$query = $this->db->query("SELECT *  FROM " . DB_PREFIX . "news WHERE news_id = '" . (int)$id . "'"); 
 
		if ($query->num_rows) {
			return $query->row;
		} else {
			return false;
		}
	}
   
	public function getAllNews($data) {
		$sql = "SELECT * FROM " . DB_PREFIX . "news n LEFT JOIN " . DB_PREFIX . "news_group ng ON n.group_id = ng.group_id WHERE 1 ORDER BY date_added DESC";
		
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
   
	public function deleteNews($id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "news WHERE news_id = '" . (int)$id . "'");
	}
   
	public function countNews() {
		$query = $this->db->query("SELECT COUNT(news_id) total FROM " . DB_PREFIX . "news");
	
		return $query->row['total'];
	}
}
?>