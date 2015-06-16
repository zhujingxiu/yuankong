<?php 
class ModelExtensionAffiliateGroup extends Model {
    public function addAffiliateGroup($data) {
        $fields = array(
            'name' => isset($data['name']) ? strip_tags(trim($data['name'])) : '',
            'show' => isset($data['show']) ? (int)$data['show'] : 0,
            'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0
        );

        return $this->db->insert("affiliate_group",$fields);
    }

    public function editAffiliateGroup($group_id, $data) {
        $fields = array(
            'name' => isset($data['name']) ? strip_tags(trim($data['name'])) : 0,
            'show' => isset($data['show']) ? (int)$data['show'] : 0,
            'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0
        );

        return $this->db->update("affiliate_group",array('group_id'=>$group_id),$fields);
    }
    
    public function deleteAffiliateGroup($group_id) {
        $this->db->delete("affiliate_group",array('group_id' => (int)$group_id));
    }
        
    public function getAffiliateGroup($group_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "affiliate_group WHERE group_id = '" . (int)$group_id . "'");
        
        return $query->row;
    }
        
    public function getAffiliateGroups($data = array()) {
        $sql = "SELECT * FROM " . DB_PREFIX . "affiliate_group ";
            
        $sort_data = array(
            'name',
            'show',
            'sort_order'
        );  
        
        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            $sql .= " ORDER BY " . $data['sort'];   
        } else {
            $sql .= " ORDER BY group_id";    
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
    
    
    public function getTotalAffiliateGroups() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "affiliate_group");
        
        return $query->row['total'];
    }   
}
