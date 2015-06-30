<?php
class ModelAccountOauth extends Model {
	public function addOauth($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "customer_oauth SET customer_id = '" . (int)$this->customer->getId() . "', openid = '" . $this->db->escape($data['openid']) . "', type = '" . $this->db->escape($data['type']) . "', token = '" . $this->db->escape($data['token']) . "', expired = '" . $this->db->escape($data['expired']) . "', name = '" . $this->db->escape($data['name']) . "', face = '" . $this->db->escape($data['face']) . "', date_added = NOW(), date_updated = NOW()");
	}

	public function getOauthCustomerIdByOpenid($openid, $type) {
		$query = $this->db->query("SELECT customer_id FROM " . DB_PREFIX . "customer_oauth WHERE type = '" . $this->db->escape($type) . "' AND openid = '" . $this->db->escape($openid) . "' LIMIT 1");
		
		return $query->row;
	}
	
	public function deleteOauth($type) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "customer_oauth` WHERE type = '" . $this->db->escape($type) . "' AND customer_id = '" . (int)$this->customer->getId() . "'");
	}

	public function getOauthByType($type) {
		$query = $this->db->query("SELECT customer_id, name, face FROM " . DB_PREFIX . "customer_oauth WHERE type = '" . $this->db->escape($type) . "' AND customer_id = '" . (int)$this->customer->getId() . "' LIMIT 1");
		
		return $query->row;
	}
}