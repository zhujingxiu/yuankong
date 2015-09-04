<?php
class ModelAccountMessage extends Model {	
	public function getMessages($data = array()) {
		$sql = "SELECT * FROM `" . DB_PREFIX . "customer_message` WHERE customer_id = '" . (int)$this->customer->getId() . "'";
		   	
		$sql .= " ORDER BY `read` = '1' , date_added DESC";	
		
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
	public function getTotalMessages() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "customer_message` WHERE customer_id = '" . (int)$this->customer->getId() . "'");
			
		return $query->row['total'];
	}

	public function updateRead($message_id){
		$this->db->update('customer_message',array('message_id'=>$message_id),array('read'=>1));
	}

	public function deleteMessage($message_id){
		$this->db->delete('customer_message',array('message_id'=>$message_id));	
	}
}
