<?php
class ModelAccountAddress extends Model {
	public function addAddress($data) {
		$area_zone = array();
		if(isset($data['area']) && is_array($data['area'])){
			foreach ($data['area'] as $area_id) {
				$_area_info = $this->db->fetch('area',array('condiftion'=> array('area_id'=>$area_id)));
				if(!empty($_area_info['name'])){
					$area_zone[] = $_area_info['name'];
				}				
			}
		}
		reset($data['area']);
		$fields = array(
			'customer_id' 	=> $this->customer->getId(),
			'fullname'		=> isset($data['fullname']) ? $data['fullname'] : '',
			'company'		=> isset($data['company']) ? $data['company'] : '',
			'telephone'		=> $data['telephone'],
			'address'		=> $data['address'],
			'postcode'		=> isset($data['postcode']) ? $data['postcode'] : '',
			'province_id'	=> current($data['area']),
			'area_zone'		=> implode(" ", $area_zone),
			'areas'			=> isset($data['area']) && is_array($data['area']) ? implode("|", $data['area']) : '',
		);
		echo "<pre>";
		print_r($fields );
		echo "</pre>";exit;
		$this->db->insert("address", $fields);
		
		$address_id = $this->db->getLastId();
		
		if (!empty($data['default'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET address_id = '" . (int)$address_id . "' WHERE customer_id = '" . (int)$this->customer->getId() . "'");
		}
		
		return $address_id;
	}
	
	public function editAddress($address_id, $data) {
		$area_zone = array();
		if(isset($data['area']) && is_array($data['area'])){
			foreach ($data['area'] as $area_id) {
				$_area_info = $this->db->fetch('area',array('condiftion'=> array('area_id'=>$area_id)));
				if(!empty($_area_info['name'])){
					$area_zone[] = $_area_info['name'];
				}				
			}
		}
		$fields = array(
			'customer_id' 	=> $this->customer->getId(),
			'fullname'		=> isset($data['fullname']) ? $data['fullname'] : '',
			'company'		=> isset($data['company']) ? $data['company'] : '',
			'telephone'		=> $data['telephone'],
			'address'		=> $data['address'],
			'postcode'		=> isset($data['postcode']) ? $data['postcode'] : '',
			'province_id'	=> isset($data['province_id']) ? $data['province_id'] : '',
			'area_zone'		=> implode(" ", $area_zone),
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

		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "address WHERE address_id = '" . (int)$address_id . "' AND customer_id = '" . (int)$this->customer->getId() . "'");
		
		if ($query->num_rows) {
			$area_query = $this->db->query("SELECT * FROM ".DB_PREFIX."area WHERE area_id = '".$query->row['province_id']."'");
			return array(
					'customer_id' => $query->row['customer_id'],
					'fullname' => $query->row['fullname'],
					'telephone' => $query->row['telephone'],
					'company' => $query->row['company'],
					'address' => $query->row['address'],
					'postcode' => $query->row['postcode'],
					'province_id' => $query->row['province_id'],
					'area_zone' => $query->row['area_zone'],
					'province' => empty($area_query->row['name']) ? '' : $area_query->row['name']
				);
		} else {
			return false;	
		}
	}
	
	public function getAddresses() {
		$address_data = array();
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "address WHERE customer_id = '" . (int)$this->customer->getId() . "'");
	
		return $query->rows;
	}	
	
	public function getTotalAddresses() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "address WHERE customer_id = '" . (int)$this->customer->getId() . "'");
	
		return $query->row['total'];
	}
}