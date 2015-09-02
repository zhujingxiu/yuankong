<?php
class ModelSaleCompany extends Model {
	public function addCompany($data) {
		$area_zone = array();
		if(isset($data['area']) && is_array($data['area'])){
			foreach ($data['area'] as $area_id) {
				if($area_id){
					$_area_info = $this->db->fetch('area',array('one'=>true,'condition'=> array('area_id'=>$area_id)));
					if(!empty($_area_info['name'])){
						$area_zone[] = $_area_info['name'];
					}
				}				
			}
		}
		$salt = substr(md5(uniqid(rand(), true)), 0, 9);
		$password = sha1($salt . sha1($salt . sha1($data['password'])));
		$fileds = array(
			'title' 		=> $data['title'],
			'corporation' 	=> $data['corporation'],
			'mobile_phone' 	=> $data['mobile_phone'],
			'email' 		=> $data['email'],
			'telephone' 	=> $data['telephone'],
			'fax' 			=> $data['fax'],
			'area_zone' 	=> implode(" ", $area_zone),
			'areas' 		=> implode("|",$data['area']),
			'postcode' 		=> isset($data['postcode']) ? $data['postcode'] : '',
			'address' 		=> isset($data['address']) ? $data['address'] : '',
			'status' 		=> isset($data['status']) ? (int)$data['status'] : 0,
			'logo' 			=> isset($data['logo']) ? htmlspecialchars_decode($data['logo']) : '',
			'cover' 		=> isset($data['cover']) ? htmlspecialchars_decode($data['cover']) : '',
			'description' 	=> isset($data['description']) ? strip_tags($data['description']) : '',
			'zone_id' 		=> $data['zone_id'],
			'recommend' 	=> $data['recommend'],
			'deposit' 		=> $data['deposit'],
			'viewed' 		=> $data['viewed'],
			'sort_order' 	=> $data['sort_order'],
			'credit' 		=> (float)$data['credit'],
			'code' 			=> isset($data['code']) ? $data['code'] : '',	
			'identity_number'=> isset($data['identity_number']) ? $data['identity_number'] : '',	
			'date_added'	=> date('Y-m-d H:i:s')		
		);

      	$company_id = $this->db->insert("company",$fileds);    

      	if(isset($data['group_id']) && is_array($data['group_id'])) {
      		$this->db->delete('company_to_group',array('company_id'=>$company_id));
      		foreach ($data['group_id'] as $group) {
      			$this->db->insert('company_to_group',array('company_id'=>$company_id,'group_id'=>$group));
      		}
      	}

      	$this->db->delete('customer',array('company_id'=>$company_id));
      	$fileds =array(
      		'fullname' 	    => $data['corporation'],
			'mobile_phone' 	=> $data['mobile_phone'],
			'email' 		=> $data['email'],
			'telephone' 	=> $data['telephone'],
			'fax' 			=> $data['fax'],
			'salt' 			=> $salt,
			'password' 		=> $password,
			'company_id'	=> $company_id,
			'avatar' 		=> isset($data['logo']) ? htmlspecialchars_decode($data['logo']) : '',
			'customer_group_id'=> $this->config->get('config_customer_group_id'),
			'status' 		=> isset($data['status']) ? (int)$data['status'] : 0,
			'approved'		=> 0,
			'date_added'	=> date('Y-m-d H:i:s')
      	);
      	$this->db->insert('customer',$fileds);
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
		$fileds = array(
			'title' 		=> $data['title'],
			'corporation' 	=> $data['corporation'],
			'mobile_phone' 	=> $data['mobile_phone'],
			'email' 		=> $data['email'],
			'telephone' 	=> $data['telephone'],
			'fax' 			=> $data['fax'],
			'address' 		=> isset($data['address']) ? $data['address'] : '',
			'postcode' 		=> isset($data['postcode']) ? $data['postcode'] : '',
			'status' 		=> isset($data['status']) ? (int)$data['status'] : 0,
			'logo' 			=> isset($data['logo']) ? htmlspecialchars_decode($data['logo']) : '',
			'cover' 		=> isset($data['cover']) ? htmlspecialchars_decode($data['cover']) : '',
			'description' 	=> isset($data['description']) ? strip_tags($data['description']) : '',
			'zone_id' 		=> $data['zone_id'],
			'recommend' 	=> $data['recommend'],
			'deposit' 		=> $data['deposit'],
			'viewed' 		=> $data['viewed'],
			'sort_order' 	=> $data['sort_order'],
			'credit' 		=> (float)$data['credit'],
			'code' 			=> isset($data['code']) ? $data['code'] : '',
			'identity_number'=> isset($data['identity_number']) ? $data['identity_number'] : ''
		);
		if($area_zone){
			$fileds['area_zone'] = implode(" ", $area_zone);
			$fileds['areas'] = implode("|",$data['area']);
		}
		$this->db->update("company", array('company_id' => (int)$company_id),$fileds);
		if(isset($data['group_id']) && is_array($data['group_id'])) {
      		$this->db->delete('company_to_group',array('company_id'=>$company_id));
      		foreach ($data['group_id'] as $group) {
      			$this->db->insert('company_to_group',array('company_id'=>$company_id,'group_id'=>$group));
      		}
      	}

      	$customer =array(
      		'fullname' 	    => $data['corporation'],
			'mobile_phone' 	=> $data['mobile_phone'],
			'email' 		=> $data['email'],
			'telephone' 	=> $data['telephone'],
			'fax' 			=> $data['fax'],
			'status' 		=> isset($data['status']) ? (int)$data['status'] : 0,
			'avatar' 		=> isset($data['logo']) ? htmlspecialchars_decode($data['logo']) : '',
      	);
      	$this->db->update('customer',array('company_id'=>$company_id),$customer);
      	if ($data['password']) {
        	$this->db->query("UPDATE " . DB_PREFIX . "company SET salt = '" . $this->db->escape($salt = substr(md5(uniqid(rand(), true)), 0, 9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($data['password'])))) . "' WHERE company_id = '" . (int)$company_id . "'");
        	$this->db->query("UPDATE " . DB_PREFIX . "customer SET salt = '" . $this->db->escape($salt = substr(md5(uniqid(rand(), true)), 0, 9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($data['password'])))) . "' WHERE company_id = '" . (int)$company_id . "'");
      	}
      	if (isset($data['module'])) {
      		$this->db->delete('company_module',array('company_id'=>$company_id));
      		foreach ($data['module'] as $item) {
      			$fileds = array(
	      			'company_id' => $company_id,
	      			'title' => trim($item['title']),	      			
	      			'image'	=> htmlspecialchars_decode($item['image']),
	      			'status'=> isset($item['status']) ? (int)$item['status'] : 0	      			
	      		);
	      		$this->db->insert("company_module" , $fileds);
      		}     		
        	
      	}
	}

	
	public function deleteCompany($company_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "company WHERE company_id = '" . (int)$company_id . "'");
	}
	
	public function getCompany($company_id) {
		$query = $this->db->query("SELECT c.*,cz.name zone FROM " . DB_PREFIX . "company c LEFT JOIN ".DB_PREFIX."company_zone cz ON c.zone_id = cz.zone_id WHERE c.company_id = '" . (int)$company_id . "'");
	
		return $query->row;
	}
	
	public function getCompanyByEmail($email) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "company WHERE LCASE(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");
	
		return $query->row;
	}

	public function getCompanyByMobilePhone($mobile_phone) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "company WHERE mobile_phone = '" . $this->db->escape($mobile_phone) . "'");
	
		return $query->row;
	}

	public function getCompanies($data = array()) {
		$sql = "SELECT c.*,cz.name zone FROM " . DB_PREFIX . "company c LEFT JOIN ".DB_PREFIX."company_zone cz ON c.zone_id = cz.zone_id ";

		$implode = array();
		
		if (!empty($data['filter_mobile_phone'])) {
			$implode[] = "c.mobile_phone LIKE '" . $this->db->escape($data['filter_mobile_phone']) . "%'";
		}

		if (!empty($data['filter_title'])) {
			$implode[] = "c.title LIKE '" . $this->db->escape($data['filter_title']) . "%'";
		}

		if (!empty($data['filter_corporation'])) {
			$implode[] = "c.corporation LIKE '" . $this->db->escape($data['filter_corporation']) . "%'";
		}

		if (!empty($data['filter_email'])) {
			$implode[] = "LCASE(c.email) = '" . $this->db->escape(utf8_strtolower($data['filter_email'])) . "'";
		}
		
		if (!empty($data['filter_code'])) {
			$implode[] = "c.code = '" . $this->db->escape($data['filter_code']) . "'";
		}

		if (isset($data['filter_zone_id']) && !is_null($data['filter_zone_id'])) {
			$implode[] = "c.zone_id = '" . (int)$data['filter_zone_id'] . "'";
		}

		if (isset($data['filter_group_id']) && !is_null($data['filter_group_id'])) {
			$cid= array();
			$query = $this->db->query("SELECT company_id FROM ".DB_PREFIX."company_to_group WHERE group_id = '".(int)$data['filter_group_id']."'");
			if($query->num_rows){
				foreach ($query->rows as $row) {
					$cid[]= (int)$row['company_id'];
				}
			}
			if($cid)
			$implode[] = "c.company_id IN (" . implode(",", $cid) . ")";
		}
					
		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$implode[] = "c.status = '" . (int)$data['filter_status'] . "'";
		}	
		
		if (isset($data['filter_approved']) && !is_null($data['filter_approved'])) {
			$implode[] = "c.approved = '" . (int)$data['filter_approved'] . "'";
		}		
		
		if (!empty($data['filter_date_added'])) {
			$implode[] = "DATE(c.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}
		
		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}
		
		$sort_data = array(
			'c.title',
			'c.corporation',
			'c.mobile_phone',
			'c.zone_id',
			'c.code',
			'c.status',
			'c.approved',
			'c.date_added',
			'c.sort_order'
		);	
			
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY c.date_added";	
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
	

	
	public function getCompanyGroups($company_id,$farmat=false) {
		$data = array();
		$query = $this->db->query("SELECT c2g.group_id,cg.name,cg.tag FROM " . DB_PREFIX . "company_to_group c2g LEFT JOIN ".DB_PREFIX."company_group cg ON cg.group_id = c2g.group_id WHERE company_id = '".(int)$company_id."'");
	
		if($query->num_rows){
			foreach ($query->rows as $row) {
				if($farmat){
					$data[] = $row['group_id'];
				}else{
					$data[$row['group_id']] = $row;
				}
			}	
		} 

		return $data;
	}
		
	public function getTotalCompanies($data = array()) {
      	$sql = "SELECT COUNT(c.company_id) AS total FROM " . DB_PREFIX . "company c";
		

		$implode = array();
		
		if (!empty($data['filter_mobile_phone'])) {
			$implode[] = "c.mobile_phone LIKE '" . $this->db->escape($data['filter_mobile_phone']) . "%'";
		}

		if (!empty($data['filter_title'])) {
			$implode[] = "c.title LIKE '" . $this->db->escape($data['filter_title']) . "%'";
		}

		if (!empty($data['filter_corporation'])) {
			$implode[] = "c.corporation LIKE '" . $this->db->escape($data['filter_corporation']) . "%'";
		}

		if (!empty($data['filter_email'])) {
			$implode[] = "LCASE(c.email) = '" . $this->db->escape(utf8_strtolower($data['filter_email'])) . "'";
		}
		
		if (!empty($data['filter_code'])) {
			$implode[] = "c.code = '" . $this->db->escape($data['filter_code']) . "'";
		}

		if (isset($data['filter_zone_id']) && !is_null($data['filter_zone_id'])) {
			$implode[] = "c.zone_id = '" . (int)$data['filter_zone_id'] . "'";
		}

		if (isset($data['filter_group_id']) && !is_null($data['filter_group_id'])) {
			$cid= array();
			$query = $this->db->query("SELECT company_id FROM ".DB_PREFIX."company_to_group WHERE group_id = '".(int)$data['filter_group_id']."'");
			if($query->num_rows){
				foreach ($query->rows as $row) {
					$cid[]= (int)$row['company_id'];
				}

			}
			if($cid)
			$implode[] = "c.company_id IN (" . implode(",", $cid) . ")";
		}
					
		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$implode[] = "c.status = '" . (int)$data['filter_status'] . "'";
		}	
		
		if (isset($data['filter_approved']) && !is_null($data['filter_approved'])) {
			$implode[] = "c.approved = '" . (int)$data['filter_approved'] . "'";
		}		
		
		if (!empty($data['filter_date_added'])) {
			$implode[] = "DATE(c.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}
		
		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}
				
		$query = $this->db->query($sql);
				
		return $query->row['total'];
	}

	public function addFile($company_id,$data){
		$fileds = array(
			'company_id'	=> $company_id,
			'mode'	=> $data['mode'],
			'path'	=> htmlspecialchars_decode($data['path']),
			'note'	=> isset($data['note']) ? strip_tags($data['note']) : '',
			'sort'	=> $data['sort'],
			'status'	=> 0,
			'date_added'=> date('Y-m-d H:i:s')
		);
		$this->db->insert("company_file" ,$fileds);
	}

	public function saveFile($file_id,$status=0,$sort=0,$note=''){
		$fileds = array(
			'status' => $status,
			'sort'   => $sort,
			'note'	 => strip_tags($note),
			'date_added'=>date('Y-m-d H:i:s')
		);

		$this->db->update('company_file',array('file_id'=>$file_id),$fileds);
		return true;
	}

	public function deleteFile($file_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "company_file WHERE file_id = '" . (int)$file_id . "'");
		return true;
	}
	public function getCompanyModules($company_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "company_module WHERE company_id = '" . (int)$company_id . "' ");
	
		return $query->rows;
	}
	public function getCompanyFile($file_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "company_file WHERE file_id = '" . (int)$file_id . "' ");
	
		return $query->row;
	}
	public function getFiles($company_id, $start = 0, $limit = 10) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "company_file WHERE company_id = '" . (int)$company_id . "' ORDER BY date_added DESC LIMIT " . (int)$start . "," . (int)$limit);
	
		return $query->rows;
	}
	
	public function getTotalFiles($company_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "company_file WHERE company_id = '" . (int)$company_id . "'");
	
		return $query->row['total'];
	}

	public function addMember($company_id,$data){
		$fileds = array(
			'company_id'=> $company_id,
			'name'		=> $data['name'],
			'position'	=> $data['position'],
			'avatar'	=> isset($data['avatar']) ? htmlspecialchars_decode($data['avatar']) : '',
			'note'		=> isset($data['note']) ?  strip_tags($data['note']) : '',
			'sort'		=> $data['sort'],
			'date_added'=> date('Y-m-d H:i:s')
		);
		$this->db->insert("company_member" ,$fileds);
	}
	public function saveMember($member_id,$data){
		$fileds = array(
			'name' 		=> $data['name'],
			'position' 	=> $data['position'],
			'sort'   	=> isset($data['sort']) ? (int)$data['sort'] : 1,
			'note'	 	=> isset($data['note']) ? strip_tags(htmlspecialchars_decode($data['note'])) : '',
			'date_added'=>date('Y-m-d H:i:s')
		);

		$this->db->update('company_member',array('member_id'=>$member_id),$fileds);
		return true;
	}
	public function deleteMember($member_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "company_member WHERE member_id = '" . (int)$member_id . "'");
		return true;
	}
	public function getCompanyMember($member_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "company_member WHERE member_id = '" . (int)$member_id . "' ");
	
		return $query->row;
	}
	public function getMembers($company_id, $start = 0, $limit = 10) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "company_member WHERE company_id = '" . (int)$company_id . "' ORDER BY date_added DESC LIMIT " . (int)$start . "," . (int)$limit);
	
		return $query->rows;
	}
	
	public function getTotalMembers($company_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "company_member WHERE company_id = '" . (int)$company_id . "'");
	
		return $query->row['total'];
	}

	public function addCase($company_id,$data){
		$fileds = array(
			'company_id'=> $company_id,
			'title'		=> $data['title'],
			'photo'	=> isset($data['photo']) ? htmlspecialchars_decode($data['photo']) : '',
			'sort'		=> $data['sort'],
			'date_added'=> date('Y-m-d H:i:s')
		);
		$this->db->insert("company_case" ,$fileds);
	}
	public function saveCase($case_id,$data){
		$fileds = array(
			'title' 		=> $data['title'],			
			'sort'   	=> isset($data['sort']) ? (int)$data['sort'] : 1,
			'photo'	 	=> isset($data['photo']) ? htmlspecialchars_decode($data['photo']) : '',
			'date_added'=>date('Y-m-d H:i:s')
		);

		$this->db->update('company_case',array('case_id'=>$case_id),$fileds);
		return true;
	}
	public function deleteCase($case_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "company_case WHERE case_id = '" . (int)$case_id . "'");
		return true;
	}
	public function getCompanyCase($case_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "company_case WHERE case_id = '" . (int)$case_id . "' ");
	
		return $query->row;
	}
	public function getCases($company_id, $start = 0, $limit = 10) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "company_case WHERE company_id = '" . (int)$company_id . "' ORDER BY date_added DESC LIMIT " . (int)$start . "," . (int)$limit);
	
		return $query->rows;
	}
	
	public function getTotalCases($company_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "company_case WHERE company_id = '" . (int)$company_id . "'");
	
		return $query->row['total'];
	}
		
	public function getTotalCompaniesAwaitingApproval() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "company WHERE status = '0' OR approved = '0'");

		return $query->row['total'];
	}	
	
	public function getTotalCompanysByZoneId($zone_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "company WHERE zone_id = '" . (int)$zone_id . "'");
		
		return $query->row['total'];
	}

	public function getApprovedCompanies(){
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."company WHERE status = '1' AND approved = '1'");
		return $query->rows;
	}


	public function approve($company_id,$notify=false) {
		$company_info = $this->getCompany($company_id);
			
		if ($company_info) {
			$this->db->query("UPDATE " . DB_PREFIX . "company SET approved = '1' WHERE company_id = '" . (int)$company_id . "'");
			$this->db->query("UPDATE " . DB_PREFIX . "customer SET approved = '1' WHERE company_id = '" . (int)$company_id . "'");
			if($notify){
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
	}		
}
