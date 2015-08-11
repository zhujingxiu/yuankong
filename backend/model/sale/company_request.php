<?php 
class ModelSaleCompanyRequest extends Model {
    public function addCompanyRequest($data) {
        $fields = array(
            'account' => isset($data['account']) ? trim($data['account']) : '',
            'mobile_phone' => isset($data['mobile_phone']) ? trim($data['mobile_phone']) : '',
            'company_id' => isset($data['company_id']) ? (int)$data['company_id'] : 0,
            'status' => isset($data['status']) ? (int)$data['status'] : 0,
            'note' => isset($data['note']) ? strip_tags(trim($data['note'])) : '',
            'date_added' => date('Y-m-d H:i:s')
        );

        return $this->db->insert("company_request",$fields);
    }

    public function editCompanyRequest($request_id, $data) {
        $fields = array(
            'account' => isset($data['account']) ? trim($data['account']) : '',
            'mobile_phone' => isset($data['mobile_phone']) ? trim($data['mobile_phone']) : '',
            'company_id' => isset($data['company_id']) ? (int)$data['company_id'] : 0,
            'status' => isset($data['status']) ? (int)$data['status'] : 0,
            'note' => isset($data['note']) ? strip_tags(trim($data['note'])) : '',
            'user_id'=> $this->user->getId(),
            'date_modified' => date('Y-m-d H:i:s')
        );

        return $this->db->update("company_request",array('request_id'=>$request_id),$fields);
    }
    
    public function deleteCompanyRequest($request_id) {
        $this->db->delete("company_request",array('request_id' => (int)$request_id));
    }
        
    public function getCompanyRequest($request_id) {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "company_request WHERE request_id = '" . (int)$request_id . "'");
        
        return $query->row;
    }
        
    public function getCompanyRequests($data = array()) {
        $sql = "SELECT cr.*,c.title company FROM " . DB_PREFIX . "company_request cr LEFT JOIN ".DB_PREFIX."company c ON cr.company_id = c.company_id ";
        $implode = array();
        
        if (!empty($data['filter_mobile_phone'])) {
            $implode[] = "cr.mobile_phone LIKE '" . $this->db->escape($data['filter_mobile_phone']) . "%'";
        }

        if (!empty($data['filter_account'])) {
            $implode[] = "cr.account LIKE '" . $this->db->escape($data['filter_account']) . "%'";
        }

        if (isset($data['filter_company']) && !is_null($data['filter_company'])) {
            $implode[] = "c.title LIKE '%" . $this->db->escape($data['filter_company']) . "%'";
        }
                    
        if (isset($data['filter_status'])) {
            $implode[] = "cr.status = '" . (int)$data['filter_status'] . "'";
        }      
        
        if (!empty($data['filter_date_added'])) {
            $implode[] = "DATE(cr.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
        }
        
        if ($implode) {
            $sql .= " WHERE " . implode(" AND ", $implode);
        }        
        $sort_data = array(
            'cr.account',
            'cr.mobile_phone',
            'cr.company_id',
            'cr.status',
            'cr.date_added'
        );  
        
        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            $sql .= " ORDER BY " . $data['sort'];   
        } else {
            $sql .= " ORDER BY cr.request_id";    
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
    
    
    public function getTotalCompanyRequests() {
        $sql = "SELECT COUNT(cr.request_id) AS total FROM " . DB_PREFIX . "company_request cr LEFT JOIN ".DB_PREFIX."company c ON cr.company_id = c.company_id ";
        $implode = array();
        
        if (!empty($data['filter_mobile_phone'])) {
            $implode[] = "cr.mobile_phone LIKE '" . $this->db->escape($data['filter_mobile_phone']) . "%'";
        }

        if (!empty($data['filter_account'])) {
            $implode[] = "cr.account LIKE '" . $this->db->escape($data['filter_account']) . "%'";
        }

        if (isset($data['filter_company'])) {
            $implode[] = "c.title LIKE '%" . $this->db->escape($data['filter_company']) . "%'";
        }
                    
        if (isset($data['filter_status'])) {
            $implode[] = "cr.status = '" . (int)$data['filter_status'] . "'";
        }      
        
        if (!empty($data['filter_date_added'])) {
            $implode[] = "DATE(cr.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
        }
        
        if ($implode) {
            $sql .= " WHERE " . implode(" AND ", $implode);
        }  
        $query = $this->db->query($sql);
        
        return $query->row['total'];
    }   
}
