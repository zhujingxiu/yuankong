<?php
class ModelAccountAddress extends Model {
	public function addAddress($data) {
		$fields = array(
			'customer_id' 	=> $this->customer->getId(),
			'nickname'		=> isset($data['nickname']) ? $data['nickname'] : '',
			'firstname'		=> isset($data['firstname']) ? $data['firstname'] : '',
			'lastname'		=> isset($data['lastname']) ? $data['lastname'] : '',
			'company'		=> isset($data['company']) ? $data['company'] : '',
			'tax_id'		=> isset($data['tax_id']) ? $data['tax_id'] : '',
			'mobile_phone'	=> $data['mobile_phone'],
			'address_1'		=> $data['address_1'],
			'address_2'		=> isset($data['address_2']) ? $data['address_2'] : '',
			'postcode'		=> isset($data['postcode']) ? $data['postcode'] : '',
			'zone_id'		=> isset($data['zone_id']) ? $data['zone_id'] : '',
			'areas'			=> isset($data['area']) && is_array($data['area']) ? implode("|", $data['area']) : '',
		);
		$this->db->insert("address", $fields);
		
		$address_id = $this->db->getLastId();
		
		if (!empty($data['default'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET address_id = '" . (int)$address_id . "' WHERE customer_id = '" . (int)$this->customer->getId() . "'");
		}
		
		return $address_id;
	}
	
	public function editAddress($address_id, $data) {
		$fields = array(
			'customer_id' 	=> $this->customer->getId(),
			'nickname'		=> isset($data['nickname']) ? $data['nickname'] : '',
			'firstname'		=> isset($data['firstname']) ? $data['firstname'] : '',
			'lastname'		=> isset($data['lastname']) ? $data['lastname'] : '',
			'company'		=> isset($data['company']) ? $data['company'] : '',
			'tax_id'		=> isset($data['tax_id']) ? $data['tax_id'] : '',
			'mobile_phone'	=> $data['mobile_phone'],
			'address_1'		=> $data['address_1'],
			'address_2'		=> isset($data['address_2']) ? $data['address_2'] : '',
			'postcode'		=> isset($data['postcode']) ? $data['postcode'] : '',
			'zone_id'		=> isset($data['zone_id']) ? $data['zone_id'] : '',
			'areas'			=> isset($data['area']) && is_array($data['area']) ? implode("|", $data['area']) : '',
		);
		$this->db->update("address",array('address_id' => (int)$address_id,'customer_id' => (int)$this->customer->getId()), $fields);
	
		if (!empty($data['default'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET address_id = '" . (int)$address_id . "' WHERE customer_id = '" . (int)$this->customer->getId() . "'");
		}
	}
	
	public function deleteAddress($address_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "address WHERE address_id = '" . (int)$address_id . "' AND customer_id = '" . (int)$this->customer->getId() . "'");
	}	
	
	public function getAddress($address_id) {
		$address_query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "address WHERE address_id = '" . (int)$address_id . "' AND customer_id = '" . (int)$this->customer->getId() . "'");
		
		if ($address_query->num_rows) {
			
			$zone_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "zone` WHERE zone_id = '" . (int)$address_query->row['zone_id'] . "'");
			
			if ($zone_query->num_rows) {
				$zone = $zone_query->row['name'];
				$zone_code = $zone_query->row['code'];
			} else {
				$zone = '';
				$zone_code = '';
			}	

			$areas = explode("|", $address_query->row['areas']);
			$area = array();
			foreach ($areas as $key => $area_id) {
				if($area_id){
					$info = $this->db->query("SELECT name FROM ".DB_PREFIX."area WHERE area_id = '".$area_id."'");
					$area[] = empty($info->row['name']) ? '' : $info->row['name'];
				}
			}	
			
			$address_data = array(
				'nickname'      => $address_query->row['nickname'],
				'firstname'      => $address_query->row['firstname'],
				'lastname'       => $address_query->row['lastname'],
				'mobile_phone'   => $address_query->row['mobile_phone'],
				'company'        => $address_query->row['company'],
				'tax_id'         => $address_query->row['tax_id'],
				'address_1'      => $address_query->row['address_1'],
				'address_2'      => $address_query->row['address_2'],
				'postcode'       => $address_query->row['postcode'],
				'zone_id'        => $address_query->row['zone_id'],
				'zone'           => $zone,
				'zone_code'      => $zone_code,
				'address_format' => $address_format,
				'areas'			 => implode(" ", $area)
			);
			
			return $address_data;
		} else {
			return false;	
		}
	}
	
	public function getAddresses() {
		$address_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "address WHERE customer_id = '" . (int)$this->customer->getId() . "'");
	
		foreach ($query->rows as $result) {
			
			$zone_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "zone` WHERE zone_id = '" . (int)$result['zone_id'] . "'");
			
			if ($zone_query->num_rows) {
				$zone = $zone_query->row['name'];
				$zone_code = $zone_query->row['code'];
			} else {
				$zone = '';
				$zone_code = '';
			}		

			$areas = explode("|", $result['areas']);
			$area = array();
			foreach ($areas as $key => $area_id) {
				if($area_id){
					$info = $this->db->query("SELECT name FROM ".DB_PREFIX."area WHERE area_id = '".$area_id."'");
					$area[] = empty($info->row['name']) ? '' : $info->row['name'];
				}
			}
		
			$address_data[$result['address_id']] = array(
				'address_id'     => $result['address_id'],
				'nickname'       => $result['nickname'],
				'firstname'      => $result['firstname'],
				'lastname'       => $result['lastname'],
				'mobile_phone'   => $result['mobile_phone'],
				'company'        => $result['company'],
				'tax_id'         => $result['tax_id'],				
				'address_1'      => $result['address_1'],
				'address_2'      => $result['address_2'],
				'postcode'       => $result['postcode'],
				'zone_id'        => $result['zone_id'],
				'zone'           => $zone,
				'zone_code'      => $zone_code,
				'address_format' => $address_format,
				'areas'			 => implode(" ", $area)
			);
		}		
		
		return $address_data;
	}	
	
	public function getTotalAddresses() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "address WHERE customer_id = '" . (int)$this->customer->getId() . "'");
	
		return $query->row['total'];
	}
}