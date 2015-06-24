<?php
class ModelServiceProject extends Model {
    public function getProject($project_id) {
        $project_query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "project` WHERE project_id = '" . (int)$project_id . "'  ");
    
        if ($project_query->num_rows) {

            return $query->rows;
        } else {
            return false;   
        }
    }
     
    public function getProjects($start = 0, $limit = 20) {
        if ($start < 0) {
            $start = 0;
        }
        
        if ($limit < 1) {
            $limit = 1;
        }   
        
        $query = $this->db->query("SELECT o.* FROM `" . DB_PREFIX . "project` o  WHERE 1 ORDER BY o.project_id DESC LIMIT " . (int)$start . "," . (int)$limit);   
    
        return $query->rows;
    }
    


    public function getTotalProjects() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "project` ");
        
        return $query->row['total'];
    }
        

    
}