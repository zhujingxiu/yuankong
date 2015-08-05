<?php
class ModelSaleCompany extends Model {
	public function addCompany($data) {
		$area_zone = array();
		if(isset($data['area']) && is_array($data['area'])){
			foreach ($data['area'] as $area_id) {
				$_area_info = $this->db->fetch('area',array('one'=>true,'condition'=> array('area_id'=>$area_id)));
				if(!empty($_area_info['name'])){
					$area_zone[] = $_area_info['name'];
				}				
			}
		}
		reset($data['area']);
		$salt = substr(md5(uniqid(rand(), true)), 0, 9);
		$fileds = array(
			'group_id' 		=> $data['group_id'],
			'fullname' 		=> $data['fullname'],
			'mobile_phone' 	=> $data['mobile_phone'],
			'email' 		=> $data['email'],
			'telephone' 	=> $data['telephone'],
			'fax' 			=> $data['fax'],
			'salt' 			=> $salt,
			'password' 		=> sha1($salt . sha1($salt . sha1($data['password']))),
			'company' 		=> $data['company'],
			'area_zone' 	=> implode(" ", $area_zone),
			'areas' 		=> implode("|",$data['area']),
			'postcode' 		=> isset($data['postcode']) ? $data['postcode'] : '',
			'province_id' 	=> current($data['area']),
			'code' 			=> isset($data['code']) ? $data['code'] : '',
			
		);
      	$this->db->insert("company",$fileds);       	
	}
	
	public function editCompany($company_id, $data) {
		$area_zone = array();
		if(isset($data['area']) && is_array($data['area'])){
			foreach ($data['area'] as $area_id) {
				$_area_info = $this->db->fetch('area',array('one'=>true,'condition'=> array('area_id'=>$area_id)));
				if(!empty($_area_info['name'])){
					$area_zone[] = $_area_info['name'];
				}				
			}
		}
		reset($data['area']);
		$salt = substr(md5(uniqid(rand(), true)), 0, 9);
		$fileds = array(
			'group_id' 		=> $data['group_id'],
			'fullname' 		=> $data['fullname'],
			'mobile_phone' 	=> $data['mobile_phone'],
			'email' 		=> $data['email'],
			'telephone' 	=> $data['telephone'],
			'fax' 			=> $data['fax'],
			'salt' 			=> $salt,
			'password' 		=> sha1($salt . sha1($salt . sha1($data['password']))),
			'company' 		=> $data['company'],
			'area_zone' 	=> implode(" ", $area_zone),
			'areas' 		=> implode("|",$data['area']),
			'postcode' 		=> isset($data['postcode']) ? $data['postcode'] : '',
			'province_id' 	=> current($data['area']),
			'code' 			=> isset($data['code']) ? $data['code'] : '',
			
		);
		$this->db->update("company", array('company_id' => (int)$company_id),$fileds);
	
      	if ($data['password']) {
        	$this->db->query("UPDATE " . DB_PREFIX . "company SET salt = '" . $this->db->escape($salt = substr(md5(uniqid(rand(), true)), 0, 9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($data['password'])))) . "' WHERE company_id = '" . (int)$company_id . "'");
      	}
	}
	
	public function deleteCompany($company_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "company WHERE company_id = '" . (int)$company_id . "'");
	}
	
	public function getCompany($company_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "company WHERE company_id = '" . (int)$company_id . "'");
	
		return $query->row;
	}
	
	public function getCompanyByEmail($email) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "company WHERE LCASE(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");
	
		return $query->row;
	}

	public function getCompanys($data = array()) {
		$sql = "SELECT a.*,ag.name group_name, a.fullname AS name, FROM " . DB_PREFIX . "company a LEFT JOIN ".DB_PREFIX."company_group ag ON a.group_id = ag.group_id ";

		$implode = array();
		
		if (!empty($data['filter_mobile_phone'])) {
			$implode[] = "a.mobile_phone LIKE '" . $this->db->escape($data['filter_mobile_phone']) . "%'";
		}

		if (!empty($data['filter_name'])) {
			$implode[] = "a.fullname LIKE '" . $this->db->escape($data['filter_name']) . "%'";
		}

		if (!empty($data['filter_email'])) {
			$implode[] = "LCASE(a.email) = '" . $this->db->escape(utf8_strtolower($data['filter_email'])) . "'";
		}
		
		if (!empty($data['filter_code'])) {
			$implode[] = "a.code = '" . $this->db->escape($data['filter_code']) . "'";
		}
					
		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$implode[] = "a.status = '" . (int)$data['filter_status'] . "'";
		}	
		
		if (isset($data['filter_approved']) && !is_null($data['filter_approved'])) {
			$implode[] = "a.approved = '" . (int)$data['filter_approved'] . "'";
		}		
		
		if (!empty($data['filter_date_added'])) {
			$implode[] = "DATE(a.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}
		
		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}
		
		$sort_data = array(
			'name',
			'a.email',
			'a.mobile_phone',
			'a.group_id',
			'a.code',
			'a.status',
			'a.approved',
			'a.date_added'
		);	
			
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY name";	
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
	
	public function approve($company_id) {
		$company_info = $this->getCompany($company_id);
			
		if ($company_info) {
			$this->db->query("UPDATE " . DB_PREFIX . "company SET approved = '1' WHERE company_id = '" . (int)$company_id . "'");
			
			$this->language->load('mail/company');
	
			$message  = sprintf($this->language->get('text_approve_welcome'), $this->config->get('config_name')) . "\n\n";
			$message .= $this->language->get('text_approve_login') . "\n";
			$message .= HTTP_CATALOG . 'index.php?route=company/login' . "\n\n";
			$message .= $this->language->get('text_approve_services') . "\n\n";
			$message .= $this->language->get('text_approve_thanks') . "\n";
			$message .= $this->config->get('config_name');
	
			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->hostname = $this->config->get('config_smtp_host');
			$mail->username = $this->config->get('config_smtp_username');
			$mail->password = $this->config->get('config_smtp_password');
			$mail->port = $this->config->get('config_smtp_port');
			$mail->timeout = $this->config->get('config_smtp_timeout');							
			$mail->setTo($company_info['email']);
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender($this->config->get('config_name'));
			$mail->setSubject(html_entity_decode(sprintf($this->language->get('text_approve_subject'), $this->config->get('config_name')), ENT_QUOTES, 'UTF-8'));
			$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
			$mail->send();
		}
	}
	
	public function getCompanysByNewsletter() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "company WHERE newsletter = '1' ORDER BY fullname, lastname, email");
	
		return $query->rows;
	}
		
	public function getTotalCompanys($data = array()) {
      	$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "company";
		
		$implode = array();
		if (!empty($data['filter_mobile_phone'])) {
			$implode[] = "mobile_phone LIKE '" . $this->db->escape($data['filter_mobile_phone']) . "%'";
		}

		if (!empty($data['filter_name'])) {
			$implode[] = "fullname LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
		}
		
		if (!empty($data['filter_email'])) {
			$implode[] = "LCASE(email) = '" . $this->db->escape(utf8_strtolower($data['filter_email'])) . "'";
		}	
				
		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$implode[] = "status = '" . (int)$data['filter_status'] . "'";
		}			
		
		if (isset($data['filter_approved']) && !is_null($data['filter_approved'])) {
			$implode[] = "approved = '" . (int)$data['filter_approved'] . "'";
		}		
				
		if (!empty($data['filter_date_added'])) {
			$implode[] = "DATE(date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}
		
		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}
				
		$query = $this->db->query($sql);
				
		return $query->row['total'];
	}
		
	public function getTotalCompanysAwaitingApproval() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "company WHERE status = '0' OR approved = '0'");

		return $query->row['total'];
	}	
	
	public function getTotalCompanysByProvinceId($province_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "company WHERE province_id = '" . (int)$province_id . "'");
		
		return $query->row['total'];
	}
				
}