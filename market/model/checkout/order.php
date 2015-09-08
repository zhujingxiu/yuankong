<?php
class ModelCheckoutOrder extends Model {
	private function generateSN($customer_id){
		/*
		$this->load->model('account/customer');
		$info = $this->model_account_customer->getCustomer($customer_id);
		$reg_time = !empty($info['date_added']) ? strtotime($info['date_added']) : time();
		*/
		$data['number'] = $this->getOrdersNumber();
		$data['date'] = date('ymd');
		$data['suffix'] = substr($this->customer->getMobilePhone(), 3,4);
		return $data;
	}	

	public function getOrdersNumber(){
		$query = $this->db->query("SELECT COUNT(order_id) total FROM ".DB_PREFIX."order WHRE DATE(date_added) = '".$this->db->escape(date('Y-m-d'))."'");
		return $query->row['total'];
	}
	public function addOrder($data) {
		$fields = array(
			'invoice_prefix' 	=> $data['invoice_prefix'],
			'order_sn' 			=> '',
			'customer_id' 		=> $data['customer_id'],
			'customer_group_id' => $data['customer_group_id'],
			'fullname' 			=> $data['fullname'],
			'mobile_phone' 		=> $data['mobile_phone'],
			'telephone' 		=> $data['telephone'],
			'email' 			=> $data['email'],
			'fax' 				=> $data['fax'],
			'payment_method' 	=> $data['payment_method'],
			'payment_code' 		=> $data['payment_code'],
			'shipping_fullname' => $data['shipping_fullname'],
			'shipping_telephone'=> $data['shipping_telephone'],
			'shipping_company'	=> $data['shipping_company'],
			'shipping_address'	=> $data['shipping_address'],
			'shipping_postcode'	=> $data['shipping_postcode'],
			'shipping_province'	=> $data['shipping_province'],
			'shipping_area_zone'=> $data['shipping_area_zone'],
			'shipping_province_id'=> $data['shipping_province_id'],			
			'shipping_method'	=> $data['shipping_method'],
			'shipping_code'		=> $data['shipping_code'],
			'order_status_id'	=> isset($data['order_status_id']) ? $data['order_status_id'] : $this->config->get('config_status_id'),
			'comment'			=> $data['comment'],
			'total'				=> (float)$data['total'],
			'language_id'		=> (int)$data['language_id'],
			'currency_id'		=> (int)$data['currency_id'],
			'currency_code'		=> $data['currency_code'],
			'currency_value'	=> (float)$data['currency_value'],
			'ip'				=> $data['ip'],
			'forwarded_ip'		=> $data['forwarded_ip'],
			'user_agent'		=> $data['user_agent'],
			'accept_language'	=> $data['accept_language'],
			'date_added'		=> date('Y-m-d H:i:s'),
			'date_modified'		=> date('Y-m-d H:i:s')
		);
		$order_id = $this->db->insert("order",$fields);
		/*
		$tmp = $this->generateSN($this->customer->getId());
		$order_sn = $order_id.$tmp['date'].$tmp['number'].$tmp['suffix'];
		$this->db->query("UPDATE ".DB_PREFIX."order SET order_sn = '".$this->db->escape($order_sn)."' WHERE order_id = '".(int)$order_id."'");
		*/
		foreach ($data['products'] as $product) { 
			$this->db->query("INSERT INTO " . DB_PREFIX . "order_product SET order_id = '" . (int)$order_id . "', product_id = '" . (int)$product['product_id'] . "', name = '" . $this->db->escape($product['name']) . "', model = '" . $this->db->escape($product['model']) . "', quantity = '" . (int)$product['quantity'] . "', price = '" . (float)$product['price'] . "', total = '" . (float)$product['total'] . "', tax = '" . (float)$product['tax'] . "', reward = '" . (int)$product['reward'] . "'");
 
			$order_product_id = $this->db->getLastId();

			foreach ($product['option'] as $option) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "order_option SET order_id = '" . (int)$order_id . "', order_product_id = '" . (int)$order_product_id . "', product_option_id = '" . (int)$option['product_option_id'] . "', product_option_value_id = '" . (int)$option['product_option_value_id'] . "', name = '" . $this->db->escape($option['name']) . "', `value` = '" . $this->db->escape($option['value']) . "', `type` = '" . $this->db->escape($option['type']) . "'");
			}
		}
		
		foreach ($data['vouchers'] as $voucher) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "order_voucher SET order_id = '" . (int)$order_id . "', description = '" . $this->db->escape($voucher['description']) . "', code = '" . $this->db->escape($voucher['code']) . "', from_name = '" . $this->db->escape($voucher['from_name']) . "', from_email = '" . $this->db->escape($voucher['from_email']) . "', to_name = '" . $this->db->escape($voucher['to_name']) . "', to_email = '" . $this->db->escape($voucher['to_email']) . "', voucher_theme_id = '" . (int)$voucher['voucher_theme_id'] . "', message = '" . $this->db->escape($voucher['message']) . "', amount = '" . (float)$voucher['amount'] . "'");
		}
			
		foreach ($data['totals'] as $total) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "order_total SET order_id = '" . (int)$order_id . "', code = '" . $this->db->escape($total['code']) . "', title = '" . $this->db->escape($total['title']) . "', text = '" . $this->db->escape($total['text']) . "', `value` = '" . (float)$total['value'] . "', sort_order = '" . (int)$total['sort_order'] . "'");
		}	

		return $order_id;
	}

	public function getOrder($order_id) {
		$order_query = $this->db->query("SELECT *, (SELECT os.name FROM `" . DB_PREFIX . "order_status` os WHERE os.order_status_id = o.order_status_id AND os.language_id = o.language_id) AS order_status FROM `" . DB_PREFIX . "order` o WHERE o.order_id = '" . (int)$order_id . "'");
			
		if ($order_query->num_rows) {
						
			$this->load->model('localisation/language');
			
			$language_info = $this->model_localisation_language->getLanguage($order_query->row['language_id']);
			
			if ($language_info) {
				$language_code = $language_info['code'];
				$language_filename = $language_info['filename'];
				$language_directory = $language_info['directory'];
			} else {
				$language_code = '';
				$language_filename = '';
				$language_directory = '';
			}
		 			
			return array(
				'order_id'                => $order_query->row['order_id'],
				'invoice_no'              => $order_query->row['invoice_no'],
				'invoice_prefix'          => $order_query->row['invoice_prefix'],			
				'customer_id'             => $order_query->row['customer_id'],
				'fullname'                => $order_query->row['fullname'],
				'mobile_phone'            => $order_query->row['mobile_phone'],
				'telephone'               => $order_query->row['telephone'],
				'fax'                     => $order_query->row['fax'],
				'payment_method'          => $order_query->row['payment_method'],
				'payment_code'            => $order_query->row['payment_code'],
				'payment_trade_no'        => $order_query->row['payment_trade_no'],
				'payment_trade_status'    => $order_query->row['payment_trade_status'],
				'shipping_fullname'       => $order_query->row['shipping_fullname'],
				'shipping_telephone'      => $order_query->row['shipping_telephone'],
				'shipping_company'        => $order_query->row['shipping_company'],
				'shipping_address'        => $order_query->row['shipping_address'],
				'shipping_postcode'       => $order_query->row['shipping_postcode'],
				'shipping_province_id'    => $order_query->row['shipping_province_id'],
				'shipping_province'       => $order_query->row['shipping_province'],
				'shipping_area_zone'      => $order_query->row['shipping_area_zone'],
				'shipping_method'         => $order_query->row['shipping_method'],
				'shipping_code'           => $order_query->row['shipping_code'],
				'comment'                 => $order_query->row['comment'],
				'total'                   => $order_query->row['total'],
				'order_status_id'         => $order_query->row['order_status_id'],
				'order_status'            => $order_query->row['order_status'],
				'language_id'             => $order_query->row['language_id'],
				'language_code'           => $language_code,
				'language_filename'       => $language_filename,
				'language_directory'      => $language_directory,
				'currency_id'             => $order_query->row['currency_id'],
				'currency_code'           => $order_query->row['currency_code'],
				'currency_value'          => $order_query->row['currency_value'],
				'ip'                      => $order_query->row['ip'],
				'forwarded_ip'            => $order_query->row['forwarded_ip'], 
				'user_agent'              => $order_query->row['user_agent'],	
				'accept_language'         => $order_query->row['accept_language'],				
				'date_modified'           => $order_query->row['date_modified'],
				'date_added'              => $order_query->row['date_added']
			);
		} else {
			return false;	
		}
	}	

	public function confirm($order_id, $order_status_id, $comment = '', $notify = false) {
		$order_info = $this->getOrder($order_id);
		 
		if ($order_info && !$order_info['order_status_id']) {

			// Ban IP
			$status = false;
			
			$this->load->model('account/customer');
			
			if ($order_info['customer_id']) {
				$results = $this->model_account_customer->getIps($order_info['customer_id']);
				
				foreach ($results as $result) {
					if ($this->model_account_customer->isBanIp($result['ip'])) {
						$status = true;
						
						break;
					}
				}
			} else {
				$status = $this->model_account_customer->isBanIp($order_info['ip']);
			}
			
			if ($status) {
				$order_status_id = $this->config->get('config_order_status_id');
			}		
				
			$this->db->query("UPDATE `" . DB_PREFIX . "order` SET order_status_id = '" . (int)$order_status_id . "', date_modified = NOW() WHERE order_id = '" . (int)$order_id . "'");

			$this->db->query("INSERT INTO " . DB_PREFIX . "order_history SET order_id = '" . (int)$order_id . "', order_status_id = '" . (int)$order_status_id . "', notify = '1', comment = '" . $this->db->escape(($comment && $notify) ? $comment : '') . "', date_added = NOW()");

			$order_product_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_product WHERE order_id = '" . (int)$order_id . "'");
			
			foreach ($order_product_query->rows as $order_product) {
				$this->db->query("UPDATE " . DB_PREFIX . "product SET quantity = (quantity - " . (int)$order_product['quantity'] . ") WHERE product_id = '" . (int)$order_product['product_id'] . "' AND subtract = '1'");
				
				$order_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_id . "' AND order_product_id = '" . (int)$order_product['order_product_id'] . "'");
			
				foreach ($order_option_query->rows as $option) {
					$this->db->query("UPDATE " . DB_PREFIX . "product_option_value SET quantity = (quantity - " . (int)$order_product['quantity'] . ") WHERE product_option_value_id = '" . (int)$option['product_option_value_id'] . "' AND subtract = '1'");
				}
			}
		
			$this->cache->delete('product');
						
			// Gift Voucher
			$this->load->model('checkout/voucher');
			
			$order_voucher_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_voucher WHERE order_id = '" . (int)$order_id . "'");
			
			foreach ($order_voucher_query->rows as $order_voucher) {
				$voucher_id = $this->model_checkout_voucher->addVoucher($order_id, $order_voucher);
				
				$this->db->query("UPDATE " . DB_PREFIX . "order_voucher SET voucher_id = '" . (int)$voucher_id . "' WHERE order_voucher_id = '" . (int)$order_voucher['order_voucher_id'] . "'");
			}			
			
			// Send out any gift voucher mails
			if ($this->config->get('config_complete_status_id') == $order_status_id) {
				$this->model_checkout_voucher->confirm($order_id);
			}
					
			// Order Totals			
			$order_total_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order_total` WHERE order_id = '" . (int)$order_id . "' ORDER BY sort_order ASC");
			
			foreach ($order_total_query->rows as $order_total) {
				$this->load->model('total/' . $order_total['code']);
				
				if (method_exists($this->{'model_total_' . $order_total['code']}, 'confirm')) {
					$this->{'model_total_' . $order_total['code']}->confirm($order_info, $order_total);
				}
			}
			$store_name = $this->config->get('config_name');
			if($notify && false){
				// Send out order confirmation mail
				$language = new Language($order_info['language_directory']);
				$language->load($order_info['language_filename']);
				$language->load('mail/order');
			 
				$order_status_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_status WHERE order_status_id = '" . (int)$order_status_id . "' AND language_id = '" . (int)$order_info['language_id'] . "'");
				
				if ($order_status_query->num_rows) {
					$order_status = $order_status_query->row['name'];	
				} else {
					$order_status = '';
				}
				
				$subject = sprintf($language->get('text_new_subject'), $this->config->get('config_name'), $order_id);
			
				// HTML Mail
				$template = new Template();
				
				$template->data['title'] = sprintf($language->get('text_new_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'), $order_id);
				
				$template->data['text_greeting'] = sprintf($language->get('text_new_greeting'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
				$template->data['text_link'] = $language->get('text_new_link');
				$template->data['text_download'] = $language->get('text_new_download');
				$template->data['text_order_detail'] = $language->get('text_new_order_detail');
				$template->data['text_instruction'] = $language->get('text_new_instruction');
				$template->data['text_order_id'] = $language->get('text_new_order_id');
				$template->data['text_date_added'] = $language->get('text_new_date_added');
				$template->data['text_payment_method'] = $language->get('text_new_payment_method');	
				$template->data['text_shipping_method'] = $language->get('text_new_shipping_method');
				$template->data['text_email'] = $language->get('text_new_email');
				$template->data['text_telephone'] = $language->get('text_new_telephone');
				$template->data['text_ip'] = $language->get('text_new_ip');
				$template->data['text_payment_address'] = $language->get('text_new_payment_address');
				$template->data['text_shipping_address'] = $language->get('text_new_shipping_address');
				$template->data['text_product'] = $language->get('text_new_product');
				$template->data['text_model'] = $language->get('text_new_model');
				$template->data['text_quantity'] = $language->get('text_new_quantity');
				$template->data['text_price'] = $language->get('text_new_price');
				$template->data['text_total'] = $language->get('text_new_total');
				$template->data['text_footer'] = $language->get('text_new_footer');
				$template->data['text_powered'] = $language->get('text_new_powered');
				
				$template->data['logo'] = $this->config->get('config_url') . 'image/' . $this->config->get('config_logo');		
				$template->data['store_name'] = $this->config->get('config_name');
				$template->data['store_url'] = HTTP_CATALOG;
				$template->data['customer_id'] = $order_info['customer_id'];
				$template->data['link'] = HTTP_CATALOG . 'index.php?route=account/order/info&order_id=' . $order_id;
				
				$template->data['order_id'] = $order_id;
				$template->data['date_added'] = date($language->get('date_format_short'), strtotime($order_info['date_added']));    	
				$template->data['payment_method'] = $order_info['payment_method'];
				$template->data['shipping_method'] = $order_info['shipping_method'];
				$template->data['email'] = $order_info['email'];
				$template->data['telephone'] = $order_info['telephone'];
				$template->data['ip'] = $order_info['ip'];
				
				if ($comment && $notify) {
					$template->data['comment'] = nl2br($comment);
				} else {
					$template->data['comment'] = '';
				}
				$areas = explode("|", $address_query->row['areas']);
				$area = array();
				foreach ($areas as $key => $area_id) {
					if($area_id){
						$info = $this->db->query("SELECT name FROM ".DB_PREFIX."area WHERE area_id = '".$area_id."'");
						$area[] = empty($info->row['name']) ? '' : $info->row['name'];
					}
				}			
					
				$format = '{area_zone} {address} {postcode} {mobile_phone} {fullname}' ;
				
				$find = array(
					'{area_zone}',
					'{address}',
					'{postcode}',
					'{mobile_phone}',
					'{fullname}'
				);
			
				$replace = array(
					'area_zone'   	=> implode(" ", $area),					
					'address' 		=> $order_info['shipping_address'],
					'postcode' 		=> $order_info['shipping_postcode'],
					'mobile_phone' 	=> $order_info['shipping_mobile_phone'],
					'fullname' 		=> $order_info['shipping_fullname'],
				);
			
				$template->data['shipping_address'] = str_replace(array("\r\n", "\r", "\n"), '<br />', preg_replace(array("/\s\s+/", "/\r\r+/", "/\n\n+/"), '<br />', trim(str_replace($find, $replace, $format))));
				
				// Products
				$template->data['products'] = array();
					
				foreach ($order_product_query->rows as $product) {
					$option_data = array();
					
					$order_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_id . "' AND order_product_id = '" . (int)$product['order_product_id'] . "'");
					
					foreach ($order_option_query->rows as $option) {
						if ($option['type'] != 'file') {
							$value = $option['value'];
						} else {
							$value = utf8_substr($option['value'], 0, utf8_strrpos($option['value'], '.'));
						}
						
						$option_data[] = array(
							'name'  => $option['name'],
							'value' => (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value)
						);					
					}
				  
					$template->data['products'][] = array(
						'name'     => $product['name'],
						'model'    => $product['model'],
						'option'   => $option_data,
						'quantity' => $product['quantity'],
						'price'    => $this->currency->format($product['price'] + ($this->config->get('config_tax') ? $product['tax'] : 0), $order_info['currency_code'], $order_info['currency_value']),
						'total'    => $this->currency->format($product['total'] + ($this->config->get('config_tax') ? ($product['tax'] * $product['quantity']) : 0), $order_info['currency_code'], $order_info['currency_value'])
					);
				}
		
				// Vouchers
				$template->data['vouchers'] = array();
				
				foreach ($order_voucher_query->rows as $voucher) {
					$template->data['vouchers'][] = array(
						'description' => $voucher['description'],
						'amount'      => $this->currency->format($voucher['amount'], $order_info['currency_code'], $order_info['currency_value']),
					);
				}
		
				$template->data['totals'] = $order_total_query->rows;
				
				if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/mail/order.tpl')) {
					$html = $template->fetch($this->config->get('config_template') . '/template/mail/order.tpl');
				} else {
					$html = $template->fetch('default/template/mail/order.tpl');
				}
	            
	            // Can not send confirmation emails for CBA orders as email is unknown
				/*
	            $this->load->model('payment/amazon_checkout');
	            if (!$this->model_payment_amazon_checkout->isAmazonOrder($order_info['order_id'])) {
	                // Text Mail
	                $text = sprintf($language->get('text_new_greeting'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8')) . "\n\n";
	                $text .= $language->get('text_new_order_id') . ' ' . $order_id . "\n";
	                $text .= $language->get('text_new_date_added') . ' ' . date($language->get('date_format_short'), strtotime($order_info['date_added'])) . "\n";
	                $text .= $language->get('text_new_order_status') . ' ' . $order_status . "\n\n";

	                if ($comment && $notify) {
	                    $text .= $language->get('text_new_instruction') . "\n\n";
	                    $text .= $comment . "\n\n";
	                }

	                // Products
	                $text .= $language->get('text_new_products') . "\n";

	                foreach ($order_product_query->rows as $product) {
	                    $text .= $product['quantity'] . 'x ' . $product['name'] . ' (' . $product['model'] . ') ' . html_entity_decode($this->currency->format($product['total'] + ($this->config->get('config_tax') ? ($product['tax'] * $product['quantity']) : 0), $order_info['currency_code'], $order_info['currency_value']), ENT_NOQUOTES, 'UTF-8') . "\n";

	                    $order_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int) $order_id . "' AND order_product_id = '" . $product['order_product_id'] . "'");

	                    foreach ($order_option_query->rows as $option) {
	                        $text .= chr(9) . '-' . $option['name'] . ' ' . (utf8_strlen($option['value']) > 20 ? utf8_substr($option['value'], 0, 20) . '..' : $option['value']) . "\n";
	                    }
	                }

	                foreach ($order_voucher_query->rows as $voucher) {
	                    $text .= '1x ' . $voucher['description'] . ' ' . $this->currency->format($voucher['amount'], $order_info['currency_code'], $order_info['currency_value']);
	                }

	                $text .= "\n";

	                $text .= $language->get('text_new_order_total') . "\n";

	                foreach ($order_total_query->rows as $total) {
	                    $text .= $total['title'] . ': ' . html_entity_decode($total['text'], ENT_NOQUOTES, 'UTF-8') . "\n";
	                }

	                $text .= "\n";

	                if ($order_info['customer_id']) {
	                    $text .= $language->get('text_new_link') . "\n";
	                    $text .= HTTP_CATALOG . 'index.php?route=account/order/info&order_id=' . $order_id . "\n\n";
	                }

	                // Comment
	                if ($order_info['comment']) {
	                    $text .= $language->get('text_new_comment') . "\n\n";
	                    $text .= $order_info['comment'] . "\n\n";
	                }

	                $text .= $language->get('text_new_footer') . "\n\n";

	                $mail = new Mail();
	                $mail->protocol = $this->config->get('config_mail_protocol');
	                $mail->parameter = $this->config->get('config_mail_parameter');
	                $mail->hostname = $this->config->get('config_smtp_host');
	                $mail->username = $this->config->get('config_smtp_username');
	                $mail->password = $this->config->get('config_smtp_password');
	                $mail->port = $this->config->get('config_smtp_port');
	                $mail->timeout = $this->config->get('config_smtp_timeout');
	                $mail->setTo($order_info['email']);
	                $mail->setFrom($this->config->get('config_email'));
	                $mail->setSender($this->config->get('config_name'));
	                $mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
	                $mail->setHtml($html);
	                $mail->setText(html_entity_decode($text, ENT_QUOTES, 'UTF-8'));
	                $mail->send();
	            }
	            */
	            
				// Admin Alert Mail
				if ($this->config->get('config_alert_mail')) {
					$subject = sprintf($language->get('text_new_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'), $order_id);
					
					// Text 
					$text  = $language->get('text_new_received') . "\n\n";
					$text .= $language->get('text_new_order_id') . ' ' . $order_id . "\n";
					$text .= $language->get('text_new_date_added') . ' ' . date($language->get('date_format_short'), strtotime($order_info['date_added'])) . "\n";
					$text .= $language->get('text_new_order_status') . ' ' . $order_status . "\n\n";
					$text .= $language->get('text_new_products') . "\n";
					
					foreach ($order_product_query->rows as $product) {
						$text .= $product['quantity'] . 'x ' . $product['name'] . ' (' . $product['model'] . ') ' . html_entity_decode($this->currency->format($product['total'] + ($this->config->get('config_tax') ? ($product['tax'] * $product['quantity']) : 0), $order_info['currency_code'], $order_info['currency_value']), ENT_NOQUOTES, 'UTF-8') . "\n";
						
						$order_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_id . "' AND order_product_id = '" . $product['order_product_id'] . "'");
						
						foreach ($order_option_query->rows as $option) {
							if ($option['type'] != 'file') {
								$value = $option['value'];
							} else {
								$value = utf8_substr($option['value'], 0, utf8_strrpos($option['value'], '.'));
							}
												
							$text .= chr(9) . '-' . $option['name'] . ' ' . (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value) . "\n";
						}
					}
					
					foreach ($order_voucher_query->rows as $voucher) {
						$text .= '1x ' . $voucher['description'] . ' ' . $this->currency->format($voucher['amount'], $order_info['currency_code'], $order_info['currency_value']);
					}
								
					$text .= "\n";

					$text .= $language->get('text_new_order_total') . "\n";
					
					foreach ($order_total_query->rows as $total) {
						$text .= $total['title'] . ': ' . html_entity_decode($total['text'], ENT_NOQUOTES, 'UTF-8') . "\n";
					}			
					
					$text .= "\n";
					
					if ($order_info['comment']) {
						$text .= $language->get('text_new_comment') . "\n\n";
						$text .= $order_info['comment'] . "\n\n";
					}
				
					$mail = new Mail(); 
					$mail->protocol = $this->config->get('config_mail_protocol');
					$mail->parameter = $this->config->get('config_mail_parameter');
					$mail->hostname = $this->config->get('config_smtp_host');
					$mail->username = $this->config->get('config_smtp_username');
					$mail->password = $this->config->get('config_smtp_password');
					$mail->port = $this->config->get('config_smtp_port');
					$mail->timeout = $this->config->get('config_smtp_timeout');
					$mail->setTo($this->config->get('config_email'));
					$mail->setFrom($this->config->get('config_email'));
					$mail->setSender($this->config->get('config_name'));
					$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
					$mail->setText(html_entity_decode($text, ENT_QUOTES, 'UTF-8'));
					$mail->send();
					
					// Send to additional alert emails
					$emails = explode(',', $this->config->get('config_alert_emails'));
					
					foreach ($emails as $email) {
						if ($email && preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $email)) {
							$mail->setTo($email);
							$mail->send();
						}
					}				
				}	
			}	
		}
	}
	
	public function update($order_id, $order_status_id, $comment = '', $notify = false) {
		$order_info = $this->getOrder($order_id);

		if ($order_info && $order_info['order_status_id']) {	

			// Ban IP
			$status = false;
			
			$this->load->model('account/customer');
			
			if ($order_info['customer_id']) {
								
				$results = $this->model_account_customer->getIps($order_info['customer_id']);
				
				foreach ($results as $result) {
					if ($this->model_account_customer->isBanIp($result['ip'])) {
						$status = true;
						
						break;
					}
				}
			} else {
				$status = $this->model_account_customer->isBanIp($order_info['ip']);
			}
			
			if ($status) {
				$order_status_id = $this->config->get('config_order_status_id');
			}		
						
			$this->db->query("UPDATE `" . DB_PREFIX . "order` SET order_status_id = '" . (int)$order_status_id . "', date_modified = NOW() WHERE order_id = '" . (int)$order_id . "'");
		
			$this->db->query("INSERT INTO " . DB_PREFIX . "order_history SET order_id = '" . (int)$order_id . "', order_status_id = '" . (int)$order_status_id . "', notify = '" . (int)$notify . "', comment = '" . $this->db->escape($comment) . "', date_added = NOW()");
	
			// Send out any gift voucher mails
			if ($this->config->get('config_complete_status_id') == $order_status_id) {
				$this->load->model('checkout/voucher');
	
				$this->model_checkout_voucher->confirm($order_id);
			}	
	
			if ($notify && false) {
				$language = new Language($order_info['language_directory']);
				$language->load($order_info['language_filename']);
				$language->load('mail/order');
			
				$subject = sprintf($language->get('text_update_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'), $order_id);
	
				$message  = $language->get('text_update_order') . ' ' . $order_id . "\n";
				$message .= $language->get('text_update_date_added') . ' ' . date($language->get('date_format_short'), strtotime($order_info['date_added'])) . "\n\n";
				
				$order_status_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_status WHERE order_status_id = '" . (int)$order_status_id . "' AND language_id = '" . (int)$order_info['language_id'] . "'");
				
				if ($order_status_query->num_rows) {
					$message .= $language->get('text_update_order_status') . "\n\n";
					$message .= $order_status_query->row['name'] . "\n\n";					
				}
				
				if ($order_info['customer_id']) {
					$message .= $language->get('text_update_link') . "\n";
					$message .= HTTP_CATALOG . 'index.php?route=account/order/info&order_id=' . $order_id . "\n\n";
				}
				
				if ($comment) { 
					$message .= $language->get('text_update_comment') . "\n\n";
					$message .= $comment . "\n\n";
				}
					
				$message .= $language->get('text_update_footer');

				$mail = new Mail();
				$mail->protocol = $this->config->get('config_mail_protocol');
				$mail->parameter = $this->config->get('config_mail_parameter');
				$mail->hostname = $this->config->get('config_smtp_host');
				$mail->username = $this->config->get('config_smtp_username');
				$mail->password = $this->config->get('config_smtp_password');
				$mail->port = $this->config->get('config_smtp_port');
				$mail->timeout = $this->config->get('config_smtp_timeout');				
				$mail->setTo($order_info['email']);
				$mail->setFrom($this->config->get('config_email'));
				$mail->setSender($this->config->get('config_name'));
				$mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));
				$mail->setText(html_entity_decode($message, ENT_QUOTES, 'UTF-8'));
				$mail->send();
			}
		}
	}

	public function getOrderProducts($order_id) {
		$query = $this->db->query("SELECT op.*,p.image FROM " . DB_PREFIX . "order_product op LEFT JOIN ".DB_PREFIX."product p ON op.product_id = p.product_id WHERE op.order_id = '" . (int)$order_id . "'");
	
		return $query->rows;
	}
}