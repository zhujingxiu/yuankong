<?php
class ModelAccountCustomer extends Model {
	public function addCustomer($data,$mail=false) {
		if (isset($data['customer_group_id']) && is_array($this->config->get('config_customer_group_display')) && in_array($data['customer_group_id'], $this->config->get('config_customer_group_display'))) {
			$customer_group_id = $data['customer_group_id'];
		} else {
			$customer_group_id = $this->config->get('config_customer_group_id');
		}
		
		$this->load->model('account/customer_group');
		
		$customer_group_info = $this->model_account_customer_group->getCustomerGroup($customer_group_id);
		$salt = substr(md5(uniqid(rand(), true)), 0, 9);
		$fields = array(
			'mobile_phone'	=> $data['mobile_phone'],
			'fullname'		=> empty($data['fullname']) ? 'yk'.$data['mobile_phone'] : $data['fullname'],
			'salt' 			=> $salt, 
			'password' 		=> sha1($salt . sha1($salt . sha1($data['password']))), 
			'customer_group_id' => (int)$customer_group_id , 
			'ip' 			=> $this->request->server['REMOTE_ADDR'], 
			'status' 		=> 1, 
			'approved' 		=> (int)!$customer_group_info['approval'] , 
			'date_added' 	=> date('Y-m-d H:i:s')
		);
		if(isset($data['email'])){
			$fields['email'] = $data['email'];
		}

		if(isset($data['telephone'])){
			$fields['telephone'] = $data['telephone'];
		}
		if(isset($data['fax'])){
			$fields['fax'] = $data['fax'];
		}
		if(isset($data['newsletter'])){
			$fields['newsletter'] = $data['newsletter'];
		}
      	
		$customer_id = $this->db->insert("customer",$fields);
		
		if($mail){
			$this->language->load('mail/customer');
			
			$subject = sprintf($this->language->get('text_subject'), $this->config->get('config_name'));
			
			$message = sprintf($this->language->get('text_welcome'), $this->config->get('config_name')) . "\n\n";
			
			if (!$customer_group_info['approval']) {
				$message .= $this->language->get('text_login') . "\n";
			} else {
				$message .= $this->language->get('text_approval') . "\n";
			}
			
			$message .= $this->url->link('account/login', '', 'SSL') . "\n\n";
			$message .= $this->language->get('text_services') . "\n\n";
			$message .= $this->language->get('text_thanks') . "\n";
			$message .= $this->config->get('config_name');
			
			$mail = new Mail();
			$mail->protocol = $this->config->get('config_mail_protocol');
			$mail->parameter = $this->config->get('config_mail_parameter');
			$mail->hostname = $this->config->get('config_smtp_host');
			$mail->username = $this->config->get('config_smtp_username');
			$mail->password = $this->config->get('config_smtp_password');
			$mail->port = $this->config->get('config_smtp_port');
			$mail->timeout = $this->config->get('config_smtp_timeout');				
			$mail->setTo($data['email']);
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender($this->config->get('config_name'));
			$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
			$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
			$mail->send();
			
			// Send to main admin email if new account email is enabled
			if ($this->config->get('config_account_mail')) {
				$message  = $this->language->get('text_signup') . "\n\n";
				$message .= $this->language->get('text_website') . ' ' . $this->config->get('config_name') . "\n";
				$message .= $this->language->get('text_firstname') . ' ' . $data['firstname'] . "\n";
				$message .= $this->language->get('text_lastname') . ' ' . $data['lastname'] . "\n";
				$message .= $this->language->get('text_customer_group') . ' ' . $customer_group_info['name'] . "\n";
				
				if ($data['company']) {
					$message .= $this->language->get('text_company') . ' '  . $data['company'] . "\n";
				}
				
				$message .= $this->language->get('text_email') . ' '  .  $data['email'] . "\n";
				$message .= $this->language->get('text_telephone') . ' ' . $data['telephone'] . "\n";
				
				$mail->setTo($this->config->get('config_email'));
				$mail->setSubject(html_entity_decode($this->language->get('text_new_customer'), ENT_QUOTES, 'UTF-8'));
				$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
				$mail->send();
				
				// Send to additional alert emails if new account email is enabled
				$emails = explode(',', $this->config->get('config_alert_emails'));
				
				foreach ($emails as $email) {
					if (strlen($email) > 0 && preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $email)) {
						$mail->setTo($email);
						$mail->send();
					}
				}
			}
		}
	}

	public function editAvatar($file){
		$this->db->update('customer',array('customer_id'=>$this->customer->getId()),array('avatar'=>trim($file)));
	}
	
	public function editCustomer($data) {
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET fullname = '" . $this->db->escape($data['fullname']) . "', email = '" . $this->db->escape($data['email']) . "', telephone = '" . $this->db->escape($data['telephone']) . "', fax = '" . $this->db->escape($data['fax']) . "' WHERE customer_id = '" . (int)$this->customer->getId() . "'");
	}

	public function editPassword($password) {
      	$this->db->query("UPDATE " . DB_PREFIX . "customer SET salt = '" . $this->db->escape($salt = substr(md5(uniqid(rand(), true)), 0, 9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($password)))) . "' WHERE customer_id = '" . $this->customer->getId() . "'");
	}

	public function validatePassword($password){
		$sql = "SELECT customer_id FROM ".DB_PREFIX."customer WHERE customer_id = '".$this->customer->getId()."' AND password = SHA1(CONCAT(salt, SHA1(CONCAT(salt, SHA1('" . $this->db->escape($password) . "')))))";
		$query = $this->db->query($sql);
		return $query->num_rows;
	}

	public function editNewsletter($newsletter) {
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET newsletter = '" . (int)$newsletter . "' WHERE customer_id = '" . (int)$this->customer->getId() . "'");
	}
					
	public function getCustomer($customer_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE customer_id = '" . (int)$customer_id . "'");
		
		return $query->row;
	}
	
	public function getCustomerByEmail($email) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");
		
		return $query->row;
	}

	public function getCustomerByMobilePhone($mobile_phone) {
		return $this->db->fetch("customer",array('one'=>true,'condition'=>array('mobile_phone' => $mobile_phone)));
	}
		
	public function getCustomerByToken($token) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE token = '" . $this->db->escape($token) . "' AND token != ''");
		
		$this->db->query("UPDATE " . DB_PREFIX . "customer SET token = ''");
		
		return $query->row;
	}
		
	public function getCustomers($data = array()) {
		$sql = "SELECT *, CONCAT(c.firstname, ' ', c.lastname) AS name, cg.name AS customer_group FROM " . DB_PREFIX . "customer c LEFT JOIN " . DB_PREFIX . "customer_group cg ON (c.customer_group_id = cg.customer_group_id) ";

		$implode = array();
		
		if (isset($data['filter_name']) && !is_null($data['filter_name'])) {
			$implode[] = "LCASE(c.fullname) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
		}
		
		if (isset($data['filter_email']) && !is_null($data['filter_email'])) {
			$implode[] = "LCASE(c.email) = '" . $this->db->escape(utf8_strtolower($data['filter_email'])) . "'";
		}
		
		if (isset($data['filter_customer_group_id']) && !is_null($data['filter_customer_group_id'])) {
			$implode[] = "cg.customer_group_id = '" . $this->db->escape($data['filter_customer_group_id']) . "'";
		}	
		
		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$implode[] = "c.status = '" . (int)$data['filter_status'] . "'";
		}	
		
		if (isset($data['filter_approved']) && !is_null($data['filter_approved'])) {
			$implode[] = "c.approved = '" . (int)$data['filter_approved'] . "'";
		}	
			
		if (isset($data['filter_ip']) && !is_null($data['filter_ip'])) {
			$implode[] = "c.customer_id IN (SELECT customer_id FROM " . DB_PREFIX . "customer_ip WHERE ip = '" . $this->db->escape($data['filter_ip']) . "')";
		}	
				
		if (isset($data['filter_date_added']) && !is_null($data['filter_date_added'])) {
			$implode[] = "DATE(c.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}
		
		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}
		
		$sort_data = array(
			'name',
			'c.email',
			'customer_group',
			'c.status',
			'c.ip',
			'c.date_added'
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
		
	public function getTotalCustomersByEmail($email) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");
		
		return $query->row['total'];
	}
	
	public function getIps($customer_id) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "customer_ip` WHERE customer_id = '" . (int)$customer_id . "'");
		
		return $query->rows;
	}	
	
	public function isBanIp($ip) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "customer_ban_ip` WHERE ip = '" . $this->db->escape($ip) . "'");
		
		return $query->num_rows;
	}	

	public function getSMS($mobile_phone){
		$filter = array(
			'one' => true,
			'condition' => array(
				'phone_number' => $mobile_phone
			) 
		);
		return $this->db->fetch('sms',$filter);
	}
	public function addSMS($mobile_phone,$sms){
		$fields = array(
			'phone_number' => $mobile_phone,
			'sms' => $sms,
			'time' => time()
		);
		return $this->db->insert('sms',$fields);
	}

	public function delSMS($mobile_phone){
		return $this->db->delete('sms',array('phone_number'=>$mobile_phone));
	}

	public function getTotalHelps(){
		$sql = "SELECT COUNT(help_id) total FROM ".DB_PREFIX."help WHERE customer_id = '".$this->customer->getId()."'";
		$query = $this->db->query($sql);
		return $query->row['total'];
	}

	public function getTotalMessages(){
		$sql = "SELECT COUNT(message_id) total FROM ".DB_PREFIX."message WHERE customer_id = '".$this->customer->getId()."'";
		$query = $this->db->query($sql);
		return $query->row['total'];		
	}
	public function getTotalReviews(){
		$sql = "SELECT COUNT(review_id) total FROM ".DB_PREFIX."review WHERE customer_id = '".$this->customer->getId()."'";
		$query = $this->db->query($sql);
		return $query->row['total'];
	}

	public function getRecomments($already = array(),$limit = 5){
		$data = array();
		$sql = "SELECT product_id FROM ".DB_PREFIX."product WHERE date_available < NOW() ";
		if(count($already)){
			$sql .= "AND product_id NOT IN (".implode(",", $already).") ";
		}
		$sql .= "ORDER BY sales DESC ,viewed DESC";
		$query = $this->db->query($sql);
		if($query->num_rows){
			foreach ($query->rows as $item) {
				$data[] = $item['product_id'];
			}
		}

		return $data;
	}

}
