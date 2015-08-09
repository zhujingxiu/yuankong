<?php 
class ModelExtensionCompanyZone extends Model {
    public function addCompanyZone($data) {
        $fields = array(
            'name' => isset($data['name']) ? strip_tags(trim($data['name'])) : '',
            'show' => isset($data['show']) ? (int)$data['show'] : 0,
            'status' => isset($data['status']) ? (int)$data['status'] : 0,
            'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0
        );

        return $this->db->insert("company_zone",$fields);
    }

    public function editCompanyZone($zone_id, $data) {
        $fields = array(
            'name' => isset($data['name']) ? strip_tags(trim($data['name'])) : 0,
            'show' => isset($data['show']) ? (int)$data['show'] : 0,
            'status' => isset($data['status']) ? (int)$data['status'] : 0,
            'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0
        );

        return $this->db->update("company_zone",array('zone_id'=>$zone_id),$fields);
    }
    
    public function deleteCompanyZone($zone_id) {
        $this->db->delete("company_zone",array('zone_id' => (int)$zone_id));
    }
        
    public function getCompanyZone($zone_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "company_zone WHERE zone_id = '" . (int)$zone_id . "'");
        
        return $query->row;
    }
        
    public function getCompanyZones($data = array()) {
        $sql = "SELECT * FROM " . DB_PREFIX . "company_zone ";
            
        $sort_data = array(
            'name',
            'show',
            'status',
            'sort_order'
        );  
        
        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            $sql .= " ORDER BY " . $data['sort'];   
        } else {
            $sql .= " ORDER BY zone_id";    
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
    
    
    public function getTotalCompanyZones() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "company_zone");
        
        return $query->row['total'];
    }   
}
