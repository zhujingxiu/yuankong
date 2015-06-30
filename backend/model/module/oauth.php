<?php
class ModelModuleOauth extends Model {
	public function install() {
		$this->db->query("
			CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "customer_oauth` (
			`oauth_id` INT( 11 ) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
			`customer_id` INT( 11 ) NOT NULL DEFAULT  '0',
			`openid` VARCHAR( 255 ) NOT NULL ,
			`type` VARCHAR( 50 ) NOT NULL ,
			`token` VARCHAR( 255 ) NOT NULL ,
			`expired` VARCHAR( 50 ) NOT NULL ,
			`name` VARCHAR( 255 ) NOT NULL ,
			`face` VARCHAR( 50 ) NOT NULL ,
			`date_added` DATETIME NOT NULL DEFAULT  '0000-00-00 00:00:00',
			`date_updated` DATETIME NOT NULL DEFAULT  '0000-00-00 00:00:00'
			) ENGINE = MYISAM DEFAULT COLLATE=utf8_general_ci;");
	}

	public function uninstall() {
		$this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "customer_oauth`;");
	}
	
	public function getOauths($data = array()) {
		$sql  = "SELECT *, co.token AS token, co.date_added AS date_added, co.date_updated AS date_updated FROM `" . DB_PREFIX . "customer_oauth` co LEFT JOIN `" . DB_PREFIX . "customer` c ON(co.customer_id = c.customer_id)";
		
		if (!empty($data['filter_customer_id']) || !empty($data['filter_name']) || !empty($data['filter_email'])) {
			$parme = array();
			
			if (!empty($data['filter_name'])) {
				$parme[] = "(co.name LIKE '%".$this->db->escape(utf8_strtolower($data['filter_name']))."%' OR CONCAT(c.firstname, ' ', c.lastname) LIKE '%".$this->db->escape(utf8_strtolower($data['filter_name']))."%')";
			}
			
			if (!empty($data['filter_customer_id'])) {
				$parme[] = "co.customer_id='".$this->db->escape(utf8_strtolower($data['filter_customer_id']))."'";
			}
			
			if (!empty($data['filter_email'])) {
				$parme[] = "c.email='".$this->db->escape(utf8_strtolower($data['filter_email']))."'";
			}
			
			$parme = implode(' AND ', $parme);
			
			$sql .= " WHERE ".$parme;
		}
		
		$sql .= " ORDER BY co.oauth_id DESC";

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
	
	public function deleteOauth($oauth_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "customer_oauth WHERE oauth_id = '" . (int)$oauth_id . "'");
	}
	
	public function getTotalOauths($data = array()) {
		$sql  = "SELECT COUNT(co.oauth_id) AS total FROM `" . DB_PREFIX . "customer_oauth` co LEFT JOIN `" . DB_PREFIX . "customer` c ON(co.customer_id = c.customer_id)";
		
		if (!empty($data['filter_customer_id']) || !empty($data['filter_name']) || !empty($data['filter_email'])) {
			$parme = array();
			
			if (!empty($data['filter_name'])) {
				$parme[] = "(co.name LIKE '%".$this->db->escape(utf8_strtolower($data['filter_name']))."%' OR CONCAT(c.firstname, ' ', c.lastname) LIKE '%".$this->db->escape(utf8_strtolower($data['filter_name']))."%')";
			}
			
			if (!empty($data['filter_customer_id'])) {
				$parme[] = "co.customer_id='".$this->db->escape(utf8_strtolower($data['filter_customer_id']))."'";
			}
			
			if (!empty($data['filter_email'])) {
				$parme[] = "c.email='".$this->db->escape(utf8_strtolower($data['filter_email']))."'";
			}
			
			$parme = implode(' AND ', $parme);
			
			$sql .= " WHERE ".$parme;
		}
		
		$query = $this->db->query($sql);
		
		$query = $query->row;
		
		if ($query) {
			return $query['total'];
		} else {
			return 0;
		}
	}
}