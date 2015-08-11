<?php 
class ModelSaleCompanyGroup extends Model {
    public function addCompanyGroup($data) {
        $fields = array(
            'name' => isset($data['name']) ? strip_tags(trim($data['name'])) : '',
            'tag' => isset($data['tag']) ? strip_tags(trim($data['tag'])) : '',
            'show' => isset($data['show']) ? (int)$data['show'] : 0,
            'status' => isset($data['status']) ? (int)$data['status'] : 0,
            'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0
        );

        return $this->db->insert("company_group",$fields);
    }

    public function editCompanyGroup($group_id, $data) {
        $fields = array(
            'name' => isset($data['name']) ? strip_tags(trim($data['name'])) : 0,
            'tag' => isset($data['tag']) ? strip_tags(trim($data['tag'])) : 0,
            'show' => isset($data['show']) ? (int)$data['show'] : 0,
            'status' => isset($data['status']) ? (int)$data['status'] : 0,
            'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0
        );

        return $this->db->update("company_group",array('group_id'=>$group_id),$fields);
    }
    
    public function deleteCompanyGroup($group_id) {
        $this->db->delete("company_group",array('group_id' => (int)$group_id));
    }
        
    public function getCompanyGroup($group_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "company_group WHERE group_id = '" . (int)$group_id . "'");
        
        return $query->row;
    }
        
    public function getCompanyGroups($data = array()) {
        $sql = "SELECT * FROM " . DB_PREFIX . "company_group ";
            
        $sort_data = array(
            'name',
            'tag',
            'show',
            'status',
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
    
    
    public function getTotalCompanyGroups() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "company_group");
        
        return $query->row['total'];
    }   
}
