<?php
class ModelServiceCompany extends Model {
        public function addCompany($data) {
        $area_zone = array();
        if(isset($data['area']) && is_array($data['area'])){
            foreach ($data['area'] as $area_id) {
                if($area_id){
                    $_area_info = $this->db->fetch('area',array('one'=>true,'condition'=> array('area_id'=>$area_id)));
                    if(!empty($_area_info['name'])){
                        $area_zone[] = $_area_info['name'];
                    }
                }               
            }
        }
        $salt = substr(md5(uniqid(rand(), true)), 0, 9);
        $password = sha1($salt . sha1($salt . sha1($data['password'])));
        $fileds = array(
            'title'         => $data['title'],
            'corporation'   => $data['corporation'],
            'mobile_phone'  => $data['mobile_phone'],
            'email'         => $data['email'],
            'area_zone'     => implode(" ", $area_zone),
            'areas'         => implode("|",$data['area']),
            'postcode'      => isset($data['postcode']) ? $data['postcode'] : '',
            'address'       => isset($data['address']) ? $data['address'] : '',
            'status'        =>  0,
            'date_added'    => date('Y-m-d H:i:s')      
        );

        $company_id = $this->db->insert("company",$fileds);    

        if(isset($data['group_id']) && is_array($data['group_id'])) {
            $this->db->delete('company_to_group',array('company_id'=>$company_id));
            foreach ($data['group_id'] as $group) {
                $this->db->insert('company_to_group',array('company_id'=>$company_id,'group_id'=>$group));
            }
        }

        $this->db->delete('customer',array('company_id'=>$company_id));
        $fileds =array(
            'fullname'      => $data['corporation'],
            'mobile_phone'  => $data['mobile_phone'],
            'email'         => $data['email'],
            'salt'          => $salt,
            'password'      => $password,
            'company_id'    => $company_id,
            'customer_group_id'=> $this->config->get('config_customer_group_id'),
            'status'        => 0,
            'approved'      => 0,
            'date_added'    => date('Y-m-d H:i:s')
        );
        $this->db->insert('customer',$fileds);
    }
    public function addCompanyRequest($data) {
        $fields =  array(
            'company_id'    => isset($data['company_id']) ? (int)$data['company_id'] : 0,
            'mobile_phone'  => isset($data['company_id']) ? $this->customer->getMobilePhone() : $data['mobile_phone'],
            'account'       => isset($data['company_id']) ? $this->customer->getFullName() : $data['account'],
            'status'        => 1,
            'date_added'    => date('Y-m-d H:i:s'),
        );
        return $this->db->insert('company_request',$fields);
    }
     
    public function getCompanies($data=array()) {
        $sql = "SELECT DISTINCT c.*,cz.name FROM `" . DB_PREFIX . "company` c LEFT JOIN ".DB_PREFIX."company_zone cz ON cz.zone_id = c.zone_id WHERE c.status = '1' AND c.approved = '1' ";
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

    public function getTotalCompanies($data=array()) {
        $sql = "SELECT COUNT(c.company_id) AS total FROM `" . DB_PREFIX . "company` c WHERE c.status = '1' AND c.approved = '1' ";
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
    public function getCompanyRank($zone_id = null,$limit = 5 ){
        $implode =  array();
        $implode[] = "status = '1'";
        $implode[] = "approved = '1'";
        if ($zone_id) {
            $implode[] = "zone_id = '" . (int)$zone_id . "'";
        }
        $query = $this->db->query("SELECT company_id,title FROM `" . DB_PREFIX . "company` WHERE ".implode(" AND ", $implode)." ORDER BY deposit DESC , recommend DESC , credit DESC ,viewed DESC LIMIT ".$limit);
        return $query->rows;
    }
    public function getCompanyZones(){
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "company_zone` WHERE `status` = '1' AND `show` = '1' ORDER BY sort_order ASC ");   
    
        return $query->rows;
    }

    public function getCompanyZone($zone_id){
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "company_zone` WHERE `status` = '1' AND `show` = '1' AND zone_id = '".$zone_id."' ");   
    
        return $query->row;
    }

    public function getCompanyGroups(){
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."company_group WHERE `status` = '1' AND `show` = '1' ORDER BY sort_order ASC");

        return $query->rows;
    }
    public function getCompany($company_id){
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."company WHERE company_id = '".(int)$company_id."' AND status = '1' AND approved = '1'");

        return $query->row;
    }

    public function getCompanyGroupsByCompanyId($company_id){
        $data = array();
        $query = $this->db->query("SELECT group_id FROM ".DB_PREFIX."company_to_group WHERE company_id = '".(int)$company_id."' ");
        foreach ($query->rows as $item) {
            $data[] = $item['group_id'];
        }
        return $data;
    }

    public function getCompanyModulesByCompanyId($company_id){
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."company_module WHERE company_id = '".(int)$company_id."' AND status = '1' ORDER BY sort ASC ");

        return $query->num_rows ? $query->rows : array();
    }

    public function getCompanyCasesByCompanyId($company_id){
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."company_case WHERE company_id = '".(int)$company_id."' ORDER BY sort ASC ,date_added DESC");

        return $query->num_rows ? $query->rows : array();
    }

    public function getCompanyMembersByCompanyId($company_id){
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."company_member WHERE company_id = '".(int)$company_id."' ORDER BY sort ASC ,date_added DESC");

        return $query->num_rows ? $query->rows : array();
    }

    public function addCompanyViewed($company_id){
        if((int)$company_id){
            $this->db->query("UPDATE ".DB_PREFIX."company SET viewed = viewed + 1 WHERE company_id = '".(int)$company_id."'");
        }
    }
}