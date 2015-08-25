<?php
class ModelToolCommon extends Model {	
	public function getPage($route) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "page` WHERE route = '".$this->db->escape(strtolower($route))."' AND status = '1' ");
		 
		return $query->row;
	}
}
