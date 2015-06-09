<?php 
class ModelExtensionHelpGroup extends Model {
    public function addHelpGroup($data) {
        $fields = array(
            'name' => isset($data['name']) ? strip_tags(trim($data['name'])) : '',
            'show' => isset($data['show']) ? (int)$data['show'] : 0,
            'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0
        );

        return $this->db->insert("help_group",$fields);
    }

    public function editHelpGroup($help_group_id, $data) {
        $fields = array(
            'name' => isset($data['name']) ? strip_tags(trim($data['name'])) : 0,
            'show' => isset($data['show']) ? (int)$data['show'] : 0,
            'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0
        );

        return $this->db->update("help_group",array('group_id'=>$help_group_id),$fields);
    }
    
    public function deleteHelpGroup($help_group_id) {
        $this->db->delete("help_group",array('help_group_id' => (int)$help_group_id));
    }
        
    public function getHelpGroup($help_group_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "help_group WHERE group_id = '" . (int)$help_group_id . "'");
        
        return $query->row;
    }
        
    public function getHelpGroups($data = array()) {
        $sql = "SELECT * FROM " . DB_PREFIX . "help_group ng  ";
            
        $sort_data = array(
            'ng.name',
            'ng.show',
            'ng.sort_order'
        );  
        
        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            $sql .= " ORDER BY " . $data['sort'];   
        } else {
            $sql .= " ORDER BY ng.group_id";    
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
    
    
    public function getTotalHelpGroups() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "help_group");
        
        return $query->row['total'];
    }   
}
