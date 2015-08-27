<?php 
class ModelSettingSetting extends Model {
	public function getSetting($group) {
		$data = array(); 
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE `group` = '" . $this->db->escape($group) . "'");
		
		foreach ($query->rows as $result) {
			if (!$result['serialized']) {
				$data[$result['key']] = $result['value'];
			} else {
				$data[$result['key']] = mb_unserialize($result['value']);
			}
		}

		return $data;
	}
	
	public function editSetting($group, $data) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE  `group` = '" . $this->db->escape($group) . "'");

		foreach ($data as $key => $value) {
			if (!is_array($value)) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "setting SET `group` = '" . $this->db->escape($group) . "', `key` = '" . $this->db->escape($key) . "', `value` = '" . $this->db->escape($value) . "'");
			} else {
				$this->db->query("INSERT INTO " . DB_PREFIX . "setting SET `group` = '" . $this->db->escape($group) . "', `key` = '" . $this->db->escape($key) . "', `value` = '" . $this->db->escape(serialize($value)) . "', serialized = '1'");
			}
		}
	}

	public function editPage($model='static',$data=array()){
		$this->db->query("DELETE FROM `" . DB_PREFIX . "page` WHERE `model` = '".$this->db->escape(strtolower($model))."'");
		if($data){
			foreach ($data as $row) {
				$fields = array(
					'title' => $row['title'],
					'route' => trim($row['route']),
					'model' => strtolower($model),
					'text'	=> $row['text'],
					'status'=> $row['status'],
					'sort'	=> $row['sort']
				);
				$this->db->insert('page',$fields);
			}
		}
	}

	public function getPages($model='static') {
		$data = array();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "page WHERE `model` = '".$this->db->escape(strtolower($model))."'");
		foreach ($query->rows as $row) {
			$row['text'] = html_entity_decode($row['text']);
			$data[] = $row;
		}
		return $data;
	}
	
	public function deleteSetting($group) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "setting WHERE `group` = '" . $this->db->escape($group) . "'");
	}
	
	public function editSettingValue($group = '', $key = '', $value = '') {
		if (!is_array($value)) {
			$this->db->query("UDPATE " . DB_PREFIX . "setting SET `value` = '" . $this->db->escape($value) . " WHERE `group` = '" . $this->db->escape($group) . "' AND `key` = '" . $this->db->escape($key) . "' ");
		} else {
			$this->db->query("UDPATE " . DB_PREFIX . "setting SET `value` = '" . $this->db->escape(serialize($value)) . "' WHERE `group` = '" . $this->db->escape($group) . "' AND `key` = '" . $this->db->escape($key) . "' AND `serialized` = '1'");
		}
	}	
}