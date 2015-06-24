<?php
class ModelModuleYkmodule extends Model {

	public function getNewses($group = 0, $limit = 5) {
		$sql = "SELECT w.*,wg.name group_name FROM ".DB_PREFIX."wiki w LEFT JOIN ".DB_PREFIX."wiki_group wg ON w.group_id = wg.group_id WHERE is_top = '1' ";
		if ($group) {
			$sql .= " AND w.group_id = '".$group."'";
		}
		
		if ($limit) {
			$sql .= " LIMIT ".$limit;
		}else{
			$sql .= " LIMIT 5";
		}
		$query = $this->db->query($sql);
	
		return $query->rows;
	}
	public function getCases( $limit = 5) {
		$sql = "SELECT * FROM ".DB_PREFIX."case ";

		if ($limit) {
			$sql .= " LIMIT ".$limit;
		}else{
			$sql .= " LIMIT 16";
		}	
		$query = $this->db->query($sql);
	
		return $query->rows;
	}

	public function getGroup($group_id=0,$model='wiki_group'){
		return $this->db->fetch(strtolower($model),array('one'=>true,'condition'=>array('group_id'=>$group_id)));

	}

	public function getWikiGroups($data=array()){
		return $this->db->fetch('wiki_group',array('condition'=>$data));

	}

	public function getWiki($data){
		if(!empty($data['group_id'])){
			$sql = "SELECT * FROM ".DB_PREFIX."wiki WHERE group_id = '".(int)$data['group_id']."'";
		}else{
			$sql = "SELECT * FROM ".DB_PREFIX."help ";
		}
		$sql .= " ORDER BY date_added DESC ";
		if(!empty($data['limit'])){
			$sql .=" LIMIT ".$data['limit'];
		}else{
			$sql .= "LIMIT 5";
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getAffiliates($data=array()){
		
		$sql = "SELECT * FROM ".DB_PREFIX."affiliate ";
		if(isset($data['group_id'])){
			$sql .=" WHERE group_id = '".(int)$data['group_id']."'";
		}
		$sql .= " ORDER BY date_added DESC ";
		if(!empty($data['limit'])){
			$sql .=" LIMIT ".$data['limit'];
		}else{
			$sql .= "LIMIT 5";
		}

		$query = $this->db->query($sql);
		return $query->rows;
	}
}