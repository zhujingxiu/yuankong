<?php
class ModelToolCommon extends Model {	
	public function getPage($route,$model='static') {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "page` WHERE `model` = '".$this->db->escape(strtolower($model))."' AND `route` = '".$this->db->escape(strtolower($route))."' AND status = '1' ");
		 
		return $query->row;
	}

	public function getQuotedLimit($customer_id){
		$query = $this->db->query("SELECT COUNT(customer_id) totals FROM ".DB_PREFIX."quoted_price WHERE customer_id = '".(int)$customer_id."' AND DATE(date_added) = '".$this->db->escape(date('Y-m-d'))."'");

		return $query->num_rows;
	}

	public function addQuoted($data){
		$area_zone = array();
		if(isset($data['area']) && is_array($data['area'])){
			foreach ($data['area'] as $area_id) {
				$_area_info = $this->db->fetch('area',array('one'=>true,'condition'=> array('area_id'=>$area_id)));
				if(!empty($_area_info['name'])){
					$area_zone[] = $_area_info['name'];
				}				
			}
		}
		$fields = array(
			'customer_id'=> $this->customer->getId(),
			'group' 	=> strtolower($data['group']),
			'season' 	=> strtolower($data['season']),
			'place' 	=> strtolower($data['place']),
			'size' 		=> (float)$data['size'],
			'status'	=> 0,
			'area_zone' => implode(" ", $area_zone),
			'date_added'=> date('Y-m-d H:i:s')
		);

		$this->db->insert('quoted_price',$fields);

	}
}
