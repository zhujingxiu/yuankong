<?php
class ModelAccountOrder extends Model {
	public function getOrder($order_id) {
		$order_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order` WHERE order_id = '" . (int)$order_id . "' AND customer_id = '" . (int)$this->customer->getId() . "' AND order_status_id > '0'");
	
		if ($order_query->num_rows) {				
			return array(
				'order_id'                => $order_query->row['order_id'],
				'invoice_no'              => $order_query->row['invoice_no'],
				'invoice_prefix'          => $order_query->row['invoice_prefix'],				
				'customer_id'             => $order_query->row['customer_id'],
				'fullname'                => $order_query->row['fullname'],
				'telephone'               => $order_query->row['telephone'],
				'fax'                     => $order_query->row['fax'],
				'mobile_phone'            => $order_query->row['mobile_phone'],
				'payment_method'          => $order_query->row['payment_method'],
				'shipping_fullname'       => $order_query->row['shipping_fullname'],
				'shipping_telephone'      => $order_query->row['shipping_telephone'],
				'shipping_company'        => $order_query->row['shipping_company'],
				'shipping_address'        => $order_query->row['shipping_address'],
				'shipping_postcode'       => $order_query->row['shipping_postcode'],
				'shipping_province_id'    => $order_query->row['shipping_province_id'],
				'shipping_province'       => $order_query->row['shipping_province'],
				'shipping_area_zone'      => $order_query->row['shipping_area_zone'],
				'shipping_method'         => $order_query->row['shipping_method'],
				'comment'                 => $order_query->row['comment'],
				'total'                   => $order_query->row['total'],
				'order_status_id'         => $order_query->row['order_status_id'],
				'language_id'             => $order_query->row['language_id'],
				'currency_id'             => $order_query->row['currency_id'],
				'currency_code'           => $order_query->row['currency_code'],
				'currency_value'          => $order_query->row['currency_value'],
				'date_modified'           => $order_query->row['date_modified'],
				'date_added'              => $order_query->row['date_added'],
				'ip'                      => $order_query->row['ip']
			);
		} else {
			return false;	
		}
	}

	public function getOrders($start = 0, $limit = 20,$filter_status=array()) {
		if ($start < 0) {
			$start = 0;
		}
		
		if ($limit < 1) {
			$limit = 1;
		}	
		$sql = "SELECT o.order_id, o.fullname, os.name as status, o.date_added, o.total, o.currency_code, o.currency_value FROM `" . DB_PREFIX . "order` o LEFT JOIN " . DB_PREFIX . "order_status os ON (o.order_status_id = os.order_status_id) WHERE o.customer_id = '" . (int)$this->customer->getId() . "' AND ";
		
		if($filter_status && is_array($filter_status) && count($filter_status)){
			$sql .= " o.order_status_id IN (".implode(",", $filter_status).")";
		}else{
			$sql .= " o.order_status_id > '0' ";
		}

		$sql .= " AND os.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY o.order_id DESC,o.date_added DESC LIMIT " . (int)$start . "," . (int)$limit;
		$query = $this->db->query($sql);	
	
		return $query->rows;
	}
	
	public function getOrderProducts($order_id) {
		$query = $this->db->query("SELECT op.*,p.image FROM " . DB_PREFIX . "order_product op LEFT JOIN ".DB_PREFIX."product p ON op.product_id = p.product_id WHERE op.order_id = '" . (int)$order_id . "'");
	
		return $query->rows;
	}
	
	public function getOrderOptions($order_id, $order_product_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_id . "' AND order_product_id = '" . (int)$order_product_id . "'");
	
		return $query->rows;
	}
	
	public function getOrderVouchers($order_id) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order_voucher` WHERE order_id = '" . (int)$order_id . "'");
		
		return $query->rows;
	}
	
	public function getOrderTotals($order_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_total WHERE order_id = '" . (int)$order_id . "' ORDER BY sort_order");
	
		return $query->rows;
	}	

	public function getOrderHistories($order_id) {
		$query = $this->db->query("SELECT date_added, os.name AS status, oh.comment, oh.notify FROM " . DB_PREFIX . "order_history oh LEFT JOIN " . DB_PREFIX . "order_status os ON oh.order_status_id = os.order_status_id WHERE oh.order_id = '" . (int)$order_id . "' AND oh.notify = '1' AND os.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY oh.date_added");
	
		return $query->rows;
	}		

	public function getTotalOrders($filter_status=array()) {
		if($filter_status && is_array($filter_status) && count($filter_status)){
			$sql = "SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order` WHERE customer_id = '" . (int)$this->customer->getId() . "' AND order_status_id IN (".implode(",", $filter_status).")";
		}else{
			$sql = "SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order` WHERE customer_id = '" . (int)$this->customer->getId() . "' AND order_status_id > '0'";
		}
      	$query = $this->db->query($sql);
		
		return $query->row['total'];
	}

	public function getTotalFinishedOrders() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order` WHERE customer_id = '" . (int)$this->customer->getId() . "' AND order_status_id = '5'");
		
		return $query->row['total'];
	}
		
	public function getTotalOrderProductsByOrderId($order_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "order_product WHERE order_id = '" . (int)$order_id . "'");
		
		return $query->row['total'];
	}
	
	public function getTotalOrderVouchersByOrderId($order_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "order_voucher` WHERE order_id = '" . (int)$order_id . "'");
		
		return $query->row['total'];
	}	
	public function getOrderShipmentHistory($order_id){
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."order_history WHERE order_id = '".(int)$order_id."' AND order_status_id = '".$this->config->get('config_shipped_status_id')."' ORDER BY date_added DESC");
		return $query->row;
	}

	public function getOrderShipments($order_id){
		$query = $this->db->query("SELECT os.*,e.title FROM ".DB_PREFIX."order_shipment os LEFT JOIN ".DB_PREFIX."express e ON os.express_id = e.express_id  WHERE os.order_id = '".(int)$order_id."' ORDER BY date_added ");
		return $query->rows;
	}

	public function getOrderStatus($order_status_id){
		$query = $this->db->query("SELECT * FROM ".DB_PREFIX."order_status WHERE order_status_id = '".(int)$order_status_id."'");
		return $query->row;
	}

	public function deleteOrder($order_id){
		$order_query = $this->db->query("SELECT order_id FROM `" . DB_PREFIX . "order` WHERE customer_id = '".$this->customer->getId()."' AND order_id = '" . (int)$order_id . "'");
		if ($order_query->num_rows) {
			$this->db->delete('order',array('order_id'=>$order_id));
			$this->db->delete('order_product',array('order_id'=>$order_id));
			$this->db->delete('order_history',array('order_id'=>$order_id));
			$this->db->delete('order_total',array('order_id'=>$order_id));
			$this->db->delete('order_shipment',array('order_id'=>$order_id));
			$this->db->delete('order_shipment_tracking',array('order_id'=>$order_id));
			$this->db->delete('order_option',array('order_id'=>$order_id));
			$this->db->delete('order_voucher',array('order_id'=>$order_id));
			$this->db->delete('review',array('order_id'=>$order_id));
		}else{
			return false;
		}
	}
}