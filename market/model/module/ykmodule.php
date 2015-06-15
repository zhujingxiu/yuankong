<?php
class ModelModuleYkmodule extends Model {

	public function getNewses($group = 0, $limit = 5) {
		$sql = "SELECT n.*,ng.name group_name FROM ".DB_PREFIX."news n LEFT JOIN ".DB_PREFIX."news_group ng ON n.group_id = ng.group_id";
		if ($group) {
			$sql .= " WHERE group_id = '".$group."'";
		}
		
		if ($limit) {
			$sql .= " LIMIT ".$limit;
		}else{
			$sql .= " LIMIT 5";
		}

		$query = $this->db->query($sql);
	
		return $query->rows;
	}
	public function getCases( $limit = 5) {
		$sql = "SELECT * FROM ".DB_PREFIX."case ";

		if ($limit) {
			$sql .= " LIMIT ".$limit;
		}else{
			$sql .= " LIMIT 16";
		}	
		$query = $this->db->query($sql);
	
		return $query->rows;
	}
}