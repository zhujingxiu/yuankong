<?php
class ModelExtensionHelp extends Model {
	public function addHelp($data) {
		$fields = array(
			'account' => isset($data['account']) ? strip_tags(trim($data['account'])) : '',
			'telephone' => isset($data['telephone']) ? strip_tags(trim($data['telephone'])) : '',
			'text' => isset($data['text']) ? strip_tags($data['text']) : '',
			'reply' => isset($data['reply']) ? htmlspecialchars_decode($data['reply']) : '',
			'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0,
			'group_id' => isset($data['group_id']) ? (int)$data['group_id'] : 0,
			'is_top' => isset($data['is_top']) ? (int)$data['is_top'] : 0,
			'tag' => isset($data['tag']) ? $data['tag'] : '',
			'status' => isset($data['status']) ? (int)$data['status'] : 1,
			'user_id' => $this->user->getId(),
			'date_added' => date('Y-m-d H:i:s'),
		);

		return $this->db->insert("help",$fields);

	}
	
	public function editHelp($id, $data) {

		$fields = array(
			'account' => isset($data['account']) ? strip_tags(trim($data['account'])) : '',
			'telephone' => isset($data['telephone']) ? strip_tags(trim($data['telephone'])) : '',
			'text' => isset($data['text']) ? strip_tags($data['text']) : '',
			'reply' => isset($data['reply']) ? htmlspecialchars_decode($data['reply']) : '',
			'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0,
			'group_id' => isset($data['group_id']) ? (int)$data['group_id'] : 0,
			'is_top' => isset($data['is_top']) ? (int)$data['is_top'] : 0,
			'tag' => isset($data['tag']) ? $data['tag'] : '',
			'status' => isset($data['status']) ? (int)$data['status'] : 1,
			'user_id' => $this->user->getId(),
			'date_added' => date('Y-m-d H:i:s'),
			'date_replied' => date('Y-m-d H:i:s'),
		);

		return $this->db->update("help",array('help_id'=>$id),$fields);
	}
	
	public function deleteHelp($help_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "help WHERE help_id = '" . (int)$help_id . "'");
		
	}
	
	public function getHelp($help_id) {

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "help  WHERE help_id = '" . (int)$help_id . "'");

		return $query->row;
	}

	public function getHelps($data = array()) {
		$sql = "SELECT h.*,CONCAT(u.lastname,u.firstname) operator FROM " . DB_PREFIX . "help h LEFT JOIN ".DB_PREFIX."user u ON u.user_id = h.user_id WHERE 1 " ;
		
		$sort_data = array(
			'h.account',
			'h.status',
			'h.is_top',
			'h.user_id',
			'h.date_added',
			'h.date_replied'
		);	
			
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY h.date_added";	
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