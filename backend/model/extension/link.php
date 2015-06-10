<?php
class ModelExtensionLink extends Model {
    public function addLink($data) {
        $fields = array(
            'name' => isset($data['name']) ? strip_tags(trim($data['name'])) : '',
            'url' => isset($data['url']) ? strip_tags(trim($data['url'])) : '',
            'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0,
            'status' => isset($data['status']) ? (int)$data['status'] : 1,
        );
        return $this->db->insert("link",$fields);
    }
    
    public function editLink($id, $data) {

        $fields = array(
            'name' => isset($data['name']) ? strip_tags(trim($data['name'])) : '',
            'url' => isset($data['url']) ? strip_tags(trim($data['url'])) : '',
            'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0,
            'status' => isset($data['status']) ? (int)$data['status'] : 1,
        );

        return $this->db->update("link",array('link_id'=>$id),$fields);
    }
    
    public function deleteLink($link_id) {
        $this->db->query("DELETE FROM " . DB_PREFIX . "link WHERE link_id = '" . (int)$link_id . "'");
    }
    
    public function getLink($link_id) {

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "link  WHERE link_id = '" . (int)$link_id . "'");

        return $query->row;
    }

    public function getLinks($data = array()) {
        $sql = "SELECT l.* FROM " . DB_PREFIX . "link l WHERE 1 " ;
        
        $sort_data = array(
            'l.name',
            'l.url',
            'l.status',
            'l.sort_order'
        );  
            
        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            $sql .= " ORDER BY " . $data['sort'];   
        } else {
            $sql .= " ORDER BY l.link_id";   
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
    
    public function getTotalLinks() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "link");
        
        return $query->row['total'];
    }
    
}