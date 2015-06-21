<?php
class ModelLocalisationArea extends Model {
	protected $_area = array();
	public function addArea($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "area SET status = '" . (int)$data['status'] . "', name = '" . $this->db->escape($data['name']) . "', code = '" . $this->db->escape($data['code']) . "', country_id = '" . (int)$data['country_id'] . "'");
			
		$this->cache->delete('area');
	}
	
	public function editArea($area_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "area SET status = '" . (int)$data['status'] . "', name = '" . $this->db->escape($data['name']) . "', code = '" . $this->db->escape($data['code']) . "', country_id = '" . (int)$data['country_id'] . "' WHERE area_id = '" . (int)$area_id . "'");

		$this->cache->delete('area');
	}
	
	public function deleteArea($area_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "area WHERE area_id = '" . (int)$area_id . "'");

		$this->cache->delete('area');	
	}
	
	public function getTotalAreas() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "area");
		
		return $query->row['total'];
	}
		
    private function getChildren($area_id=null){
        $sql = "SELECT * FROM ".DB_PREFIX."area ";
        if( $area_id != null ) {           
            $sql .= ' AND parent_id='.(int)$area_id;           
        }
        $sql .= ' ORDER BY `parent_id` ,`sort` ';
        $query = $this->db->query( $sql );            
        return $query->rows;
    }
    		
	public function getAreaTree($area_id = null ){
        $children = $this->getChildren( $area_id);
        foreach($children as $child ){
            $this->_area[$child['parent_id']][] = $child;
        }

        return $this->areaFormat(0);
    }

    private function areaFormat($parent_id=0){
        $area = array(); 
        if($this->hasChildren($parent_id)){
            $results = $this->getArea($parent_id);                     
            foreach( $results as $result ){
                $parent_area = $this->getParentArea($result['area_id']);
                $tmp = array(
                    'area_id'   => $result['area_id'],
                    'level'     => $result['level'],
                    'p_id'      => $result['parent_id'],
                    'p_name'    => (!empty($parent_area['name']) ? $parent_area['name'] : ''),
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
        $node =$this->getArea((int)$area_id);
        if(isset($node['parent_id'])){          
            $tmp = $this->getAllParentAreaByRecursion($node['parent_id']);
            $parent_area[] = $node;
            $parent_area = array_merge($tmp,$parent_area);
        }
        return $parent_area;
    }

    private function getParentArea($area_id){
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

    private function hasChildren($area_id){
        return isset($this->_area[$area_id]);
    } 
    
    private function getArea($area_id){
        return $this->_area[$area_id];
    }
}