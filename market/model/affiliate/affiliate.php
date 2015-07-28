<?php
class ModelAffiliateAffiliate extends Model {
	public function addAffiliate($data,$mail=false) {
		$salt = substr(md5(uniqid(rand(), true)), 0, 9);
		$fields = array(
			'mobile_phone'	=> $data['mobile_phone'],
			'fullname'		=> $data['fullname'],
			'company'		=> $data['company'],
			'salt' 			=> $salt, 
			'password' 		=> sha1($salt . sha1($salt . sha1($data['password']))), 
			'group_id' 		=> (int)$data['group_id'] , 
			'ip' 			=> $this->request->server['REMOTE_ADDR'], 
			'status' 		=> 1, 
			'approved' 		=> 1, 
			'date_added' 	=> date('Y-m-d H:i:s')
		);
		if(isset($data['email'])){
			$fields['email'] = $data['email'];
		}
		if(isset($data['address'])){
			$fields['address'] = $data['address'];
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
      	$customer_id = $this->db->insert("affiliate",$fields);
      	
      	$this->db->query(" code = '" . $this->db->escape(uniqid()) . "', commission = '" . (float)$this->config->get('config_commission') . "', tax = '" . $this->db->escape($data['tax']) . "', payment = '" . $this->db->escape($data['payment']) . "', cheque = '" . $this->db->escape($data['cheque']) . "', bank_name = '" . $this->db->escape($data['bank_name']) . "', bank_branch_number = '" . $this->db->escape($data['bank_branch_number']) . "', bank_swift_code = '" . $this->db->escape($data['bank_swift_code']) . "', bank_account_name = '" . $this->db->escape($data['bank_account_name']) . "', bank_account_number = '" . $this->db->escape($data['bank_account_number']) . "', status = '1', date_added = NOW()");
		if($mail){
			$this->language->load('mail/affiliate');
			
			$subject = sprintf($this->language->get('text_subject'), $this->config->get('config_name'));
			
			$message  = sprintf($this->language->get('text_welcome'), $this->config->get('config_name')) . "\n\n";
			$message .= $this->language->get('text_approval') . "\n";
			$message .= $this->url->link('affiliate/login', '', 'SSL') . "\n\n";
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
			$mail->setTo($this->request->post['email']);
			$mail->setFrom($this->config->get('config_email'));
			$mail->setSender($this->config->get('config_name'));
			$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
			$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
			$mail->send();
		}
	}
	
	public function editAffiliate($data) {

		$fields = array(
			'store_id' 		=> (int)$this->config->get('config_store_id') ,
			'mobile_phone'	=> $data['mobile_phone'],
			'fullname'		=> $data['fullname'],
			'company'		=> $data['company'],
			'group_id' 		=> (int)$data['group_id'] , 
			'ip' 			=> $this->request->server['REMOTE_ADDR'], 
			'status' 		=> 1, 
			'approved' 		=> 1, 
			'date_added' 	=> date('Y-m-d H:i:s')
		);
		if(isset($data['email'])){
			$fields['email'] = $data['email'];
		}
		if(isset($data['address'])){
			$fields['address'] = $data['address'];
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
		$this->db->update("affiliate",array('affiliate_id'=>$this->affiliate->getId()), $fields);
	}

	public function editPayment($data) {
      	$this->db->query("UPDATE " . DB_PREFIX . "affiliate SET tax = '" . $this->db->escape($data['tax']) . "', payment = '" . $this->db->escape($data['payment']) . "', cheque = '" . $this->db->escape($data['cheque']) . "', paypal = '" . $this->db->escape($data['paypal']) . "', bank_name = '" . $this->db->escape($data['bank_name']) . "', bank_branch_number = '" . $this->db->escape($data['bank_branch_number']) . "', bank_swift_code = '" . $this->db->escape($data['bank_swift_code']) . "', bank_account_name = '" . $this->db->escape($data['bank_account_name']) . "', bank_account_number = '" . $this->db->escape($data['bank_account_number']) . "' WHERE affiliate_id = '" . (int)$this->affiliate->getId() . "'");
	}
	
	public function editPassword($email, $password) {
      	$this->db->query("UPDATE " . DB_PREFIX . "affiliate SET salt = '" . $this->db->escape($salt = substr(md5(uniqid(rand(), true)), 0, 9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($password)))) . "' WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");
	}
	public function editPasswordByMobilePhone($mobile_phone, $password) {
      	$this->db->query("UPDATE " . DB_PREFIX . "affiliate SET salt = '" . $this->db->escape($salt = substr(md5(uniqid(rand(), true)), 0, 9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($password)))) . "' WHERE mobile_phone = '" . $this->db->escape($mobile_phone) . "'");
	}			
	public function getAffiliate($affiliate_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "affiliate WHERE affiliate_id = '" . (int)$affiliate_id . "'");
		
		return $query->row;
	}
	
	public function getAffiliateByEmail($email) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "affiliate WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");
		
		return $query->row;
	}
	public function getAffiliateByMobilePhone($mobile_phone) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "affiliate WHERE mobile_phone = '" . $this->db->escape($mobile_phone) . "'");
		
		return $query->row;
	}
	public function getAffiliateByCode($code) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "affiliate WHERE code = '" . $this->db->escape($code) . "'");
		
		return $query->row;
	}
			
	public function getTotalAffiliatesByEmail($email) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "affiliate WHERE LOWER(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");
		
		return $query->row['total'];
	}
}