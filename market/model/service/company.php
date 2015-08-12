<?php
class ModelServiceCompany extends Model {
    public function addCompanyRequest($data) {
        $fields =  array(
            'company_id'    => isset($data['company_id']) ? (int)$data['company_id'] : 0,
            'mobile_phone'     => $data['mobile_phone'],
            'account'       => $data['account'],
            'status'        => 1,
            'date_added'    => date('Y-m-d H:i:s'),
        );
        return $this->db->insert('company_request',$fields);
    }
     
    public function getCompanies($data=array()) {
        $sql = "SELECT DISTINCT c.*,cz.name FROM `" . DB_PREFIX . "company` c LEFT JOIN ".DB_PREFIX."company_zone cz ON cz.zone_id = c.zone_id WHERE 1 ";
        $implode = array();

        if (!empty($data['filter_company'])) {
            $implode[] = " AND c.title LIKE '" . $this->db->escape($data['filter_company']) . "%'";
        }

        if (isset($data['filter_zone']) && !is_null($data['filter_zone'])) {
            $implode[] = " AND c.zone_id = '" . (int)$data['filter_zone'] . "'";
        }

        if (isset($data['filter_group']) && !is_null($data['filter_group'])) {
            $cid= array();
            $query = $this->db->query("SELECT company_id FROM ".DB_PREFIX."company_to_group WHERE group_id = '".(int)$data['filter_group']."'");
            if($query->num_rows){
                foreach ($query->rows as $row) {
                    $cid[]= (int)$row['company_id'];
                }

            }
            if($cid)
            $implode[] = " AND c.company_id IN (" . implode(",", $cid) . ")";
        }
        if($implode){
            $sql .= implode(" ", $implode);
        }

        $sort_data = array(
            'c.title',
            'c.recommend',
            'c.credit',
            'c.viewed',
            'c.sort_order',
            'c.date_added'
        );  
        
        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            $sql .= " ORDER BY " . $data['sort'];
        } else {
            $sql .= " ORDER BY c.sort_order";   
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

    public function getTotalCompanies($data=array()) {
        $sql = "SELECT COUNT(c.company_id) AS total FROM `" . DB_PREFIX . "company` c WHERE 1 ";
        $implode = array();

        if (!empty($data['filter_company'])) {
            $implode[] = " AND c.title LIKE '" . $this->db->escape($data['filter_company']) . "%'";
        }

        if (isset($data['filter_zone']) && !is_null($data['filter_zone'])) {
            $implode[] = " AND c.zone_id = '" . (int)$data['filter_zone'] . "'";
        }

        if (isset($data['filter_group']) && !is_null($data['filter_group'])) {
            $cid= array();
            $query = $this->db->query("SELECT company_id FROM ".DB_PREFIX."company_to_group WHERE group_id = '".(int)$data['filter_group']."'");
            if($query->num_rows){
                foreach ($query->rows as $row) {
                    $cid[]= (int)$row['company_id'];
                }

            }
            if($cid)
            $implode[] = " AND c.company_id IN (" . implode(",", $cid) . ")";
        }
        if($implode){
            $sql .= implode(" AND ", $implode);
        }
        $query = $this->db->query($sql);
        return $query->row['total'];
    }

    public function getCompanyZones(){
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "company_zone` WHERE `status` = '1' AND `show` = '1' ORDER BY sort_order ASC ");   
    
        return $query->rows;
    }

    public function getCompanyGroups(){
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."company_group WHERE `status` = '1' AND `show` = '1' ORDER BY sort_order ASC");

        return $query->rows;
    }

}