<?php
class ModelServiceProject extends Model {
    public function addProject($data) {
        $fields =  array(
            'project_sn'    => 'xf'. date('YmdHis'),
            'group_id'      => $data['group_id'],
            'telephone'     => $data['telephone'],
            'account'       => $data['account'],
            'status'        => 1,
            'date_applied'  => date('Y-m-d H:i:s'),
            'date_modified' => date('Y-m-d H:i:s'),
        );
        return $this->db->insert('project',$fields);
    }
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
            $limit = 10;
        }   
        
        $query = $this->db->query("SELECT p.*,pg.name FROM `" . DB_PREFIX . "project` p LEFT JOIN ".DB_PREFIX."project_group pg ON p.group_id = pg.group_id WHERE 1 ORDER BY p.project_id DESC LIMIT " . (int)$start . "," . (int)$limit);   
    
        return $query->rows;
    }

    public function getTotalProjects() {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "project` ");
        
        return $query->row['total'];
    }

    public function getProjectGroups(){
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "project_group` ORDER BY sort_order ASC ");   
    
        return $query->rows;
    }

}