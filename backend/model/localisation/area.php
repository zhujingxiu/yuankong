<?php
class ModelLocalisationArea extends Model {
	protected $_area = array();
    public function saveArea($data) {
        if(!empty($data['area_id'])){

            $area_id = (int)$data['area_id'];
       
            $this->db->query("UPDATE `" . DB_PREFIX . "area` SET `pid` = '".(int)$data['pid']."',`name` = '" . $this->db->escape($data['name']) . "', `status` = '" . (int)$data['status'] . "' ,`sort` = '".(int)$data['sort']."'  WHERE area_id = '" . $area_id . "'");
        }else{
            $this->db->query("INSERT INTO `" . DB_PREFIX . "area` SET `pid` = '".(int)$data['pid']."', `name` = '" . $this->db->escape($data['name']) . "', `status` = '" . (int)$data['status'] . "',`sort` = '".(int)$data['sort']."'");
            $area_id = $this->db->getLastId();
        }
        return $area_id;
    }

    public function getAreaNode($area_id){
        return $this->db->fetch('area',array('one'=>true,'condition'=>array('area_id'=>$area_id)));
    }
	
	public function deleteArea($area_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "area WHERE area_id = '" . (int)$area_id . "'");

		$this->cache->delete('area');	
	}

    function getNodesByParentId($parent_id){
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."area WHERE pid = '".(int)$parent_id."' ORDER BY sort ASC ,area_id ASC");
        return $query->rows;
    }

    function getAllChildrenNodesByRecursion($parent_id){
        $children_node= array();
        $nodes = $this->getNodesByParentId($parent_id);

        if($nodes){
            foreach ($nodes as $item) {
                if($item['area_id']){
                    $tmp = $this->getAllChildrenNodesByRecursion($item['area_id']);
                    $tmp[] = $item['area_id'];
                    $children_node = array_merge($tmp,$children_node);
                }
            }
        }

        return $children_node;
    }

    public function deleteNode($node_id) {
        $all_nodes = $this->getAllChildrenNodesByRecursion($node_id);
        $all_nodes[] = $node_id;

        $this->db->query("DELETE FROM `" . DB_PREFIX . "area` WHERE area_id IN (" . implode(',', $all_nodes) . ")");
        $this->cache->delete('area');
        return count($all_nodes);
    }
	
	public function getTotalAreas() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "area");
		
		return $query->row['total'];
	}
		
    private function getChildren($area_id=null){
        $sql = "SELECT * FROM ".DB_PREFIX."area ";
        if( $area_id != null ) {           
            $sql .= ' AND pid='.(int)$area_id;           
        }
        $sql .= ' ORDER BY `pid` ,`sort` ';
        $query = $this->db->query( $sql );            
        return $query->rows;
    }
    		
	public function getAreaTree($area_id = null ){
        $children = $this->getChildren( $area_id);
        foreach($children as $child ){
            $this->_area[$child['pid']][] = $child;
        }

        return $this->areaFormat(0);
    }

    private function areaFormat($pid=0){
        $area = array(); 
        if($this->hasChildren($pid)){
            $results = $this->getArea($pid);                     
            foreach( $results as $result ){
                
                $tmp = array(
                    'area_id'   => $result['area_id'],
                    'pid'      => $result['pid'],
                    'name'      => $result['name'],
                    'status'    => $result['status'],
                    'sort'      => isset($result['sort']) ? (int)$result['sort'] : 0,
                );
                if($this->hasChildren($result['area_id'])){
                    $tmp['is_parent'] = 1;
                    $tmp['children'] = $this->areaFormat( $result['area_id'] );
                } 
                $area[] = ($tmp);           
            }           
            return $area;
        }
        return ;
    }

    private function getAllParentAreaByRecursion($area_id){
        $parent_area = array();
        $node =$this->getAreaNode((int)$area_id);
        if(isset($node['pid'])){          
            $tmp = $this->getAllParentAreaByRecursion($node['pid']);
            $parent_area[] = $node;
            $parent_area = array_merge($tmp,$parent_area);
        }
        return $parent_area;
    }

    public function getParentArea($area_id){
        $result=array('name'=>'');
        $parent_area = $this->getAllParentAreaByRecursion($area_id);
        unset($parent_area[count($parent_area)-1]);
        if(count($parent_area)){
            foreach ($parent_area as $item) {
                $result['name'] .= "/".$item['name'];
            }
        }
        return $result;
    }

    public function hasChildren($area_id){
        return isset($this->_area[$area_id]);
    } 
    
    public function getArea($area_id){
        return $this->_area[$area_id];
    }

    public function getAreas() {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "area WHERE  status = '1' ORDER BY sort");
        
        return $query->rows;
    } 
}