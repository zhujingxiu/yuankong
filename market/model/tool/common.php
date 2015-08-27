<?php
class ModelToolCommon extends Model {	
	public function getPage($route,$model='static') {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "page` WHERE `model` = '".$this->db->escape(strtolower($model))."' AND `route` = '".$this->db->escape(strtolower($route))."' AND status = '1' ");
		 
		return $query->row;
	}
}
