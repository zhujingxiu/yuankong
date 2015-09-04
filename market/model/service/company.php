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
            'status'        => 1,
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
            'status'        => 1,
            'approved'      => 0,
            'date_added'    => date('Y-m-d H:i:s')
        );
        $customer_id = $this->db->insert('customer',$fileds);
        reset($data['area']);
        $address = array(
            'customer_id'   => $customer_id,
            'fullname'      => $data['corporation'],
            'company'       => $data['title'],
            'telephone'     => $data['mobile_phone'],
            'address'       => $data['address'],
            'postcode'      => isset($data['postcode']) ? $data['postcode'] : '',
            'province_id'   => current($data['area']),
            'area_zone'     => implode(" ", $area_zone),
            'areas'         => isset($data['area']) && is_array($data['area']) ? implode("|", $data['area']) : '',
        );
        $this->db->insert("address", $address);
        
        $address_id = $this->db->getLastId();
        
        if (!empty($data['default'])) {
            $this->db->query("UPDATE " . DB_PREFIX . "customer SET address_id = '" . (int)$address_id . "' WHERE customer_id = '" . (int)$this->customer->getId() . "'");
        }
    }

    public function editCompany($company_id,$data=array()){
        $area_zone = array();
        if(isset($data['area']) && is_array($data['area'])){
            foreach ($data['area'] as $area_id) {
                $_area_info = $this->db->fetch('area',array('one'=>true,'condition'=> array('area_id'=>$area_id)));
                if(!empty($_area_info['name'])){
                    $area_zone[] = $_area_info['name'];
                }               
            }
        }
        $company = $customer = array();
        if(isset($data['title'])){
            $company['title'] = $data['title'];
        }
        if(isset($data['corporation'])){
            $company['corporation'] = $data['corporation'];
            $customer['fullname'] = $data['corporation'];
        }
        if(isset($data['mobile_phone'])){
            $company['mobile_phone'] = $data['mobile_phone'];
            $customer['mobile_phone'] = $data['mobile_phone'];
        }
        if(isset($data['email'])){
            $company['email'] = $data['email'];
            $customer['email'] = $data['email'];
        }
        if(isset($data['telephone'])){
            $company['telephone'] = $data['telephone'];
            $customer['telephone'] = $data['telephone'];
        }
        if(isset($data['fax'])){
            $company['fax'] = $data['fax'];
            $customer['fax'] = $data['fax'];
        }
        if(isset($data['postcode'])){
            $company['postcode'] = $data['postcode'];
            $customer['postcode'] = $data['postcode'];
        }
        if(isset($data['logo'])){
            $company['logo'] = htmlspecialchars_decode($data['logo']);
            $customer['avatar'] = htmlspecialchars_decode($data['logo']);
        }
        if(isset($data['cover'])){
            $company['cover'] = htmlspecialchars_decode($data['cover']);
        }
        if(isset($data['zone_id'])){
            $company['zone_id'] = $data['zone_id'];
        }
        if(isset($data['code'])){
            $company['code'] = strip_tags($data['code']);
        }

        if($area_zone && !empty($data['address'])){
            $company['area_zone'] = implode(" ", $area_zone);
            $company['areas'] = implode("|",$data['area']);
            $company['address'] = $data['address'];
        }

        if($company){
            $company['approved'] = 0;
            $this->db->update("company", array('company_id' => (int)$company_id),$company);
        }

        if($customer){
            $this->db->update('customer',array('company_id'=>$company_id),$customer);
        }

        if(isset($data['group_id']) && is_array($data['group_id'])) {
            $this->db->delete('company_to_group',array('company_id'=>$company_id));
            foreach ($data['group_id'] as $group) {
                $this->db->insert('company_to_group',array('company_id'=>$company_id,'group_id'=>$group));
            }
        }    
           
    }

    public function editDescription($company_id,$data=array()){
        $company = array();
        if(isset($data['description'])){
            $company['description'] = strip_tags($data['description']);
        }

        if(isset($data['cover'])){
            $company['cover'] = htmlspecialchars_decode($data['cover']);
        }
        if($company){
            $this->db->update("company", array('company_id' => (int)$company_id),$company);
        }
    }

    public function editModule($company_id,$data=array()){
        $module = array();
        if(isset($data['sort'])){
            $module['sort'] = (int)$data['sort'];
        }else{
            $module['sort'] = 1;
        }
        $this->db->query("DELETE FROM ".DB_PREFIX."company_module WHERE company_id = '".(int)$company_id."' AND sort = '".$module['sort']."'");
        if(isset($data['status'])){
            $module['status'] = (int)$data['status'];
        }else{
            $module['status'] = 0;
        }
        if(!empty($data['title'])){
            $module['title'] = strip_tags($data['title']);
        }
        if(isset($data['image'])){
            $module['image'] = htmlspecialchars_decode($data['image']);
        }
        $module['company_id'] =(int)$company_id;

        $this->db->insert("company_module",$module);

    }

    public function getCase($case_id){
        return $this->db->fetch('company_case',array('one'=>true,'condition'=>array('case_id'=>$case_id,'company_id'=>$this->customer->isCompany())));
    }

    public function deleteCase($case_id){
        $this->db->delete('company_case',array('case_id'=>$case_id,'company_id'=>$this->customer->isCompany()));
        return true;
    }

    public function editCase($company_id,$data=array()){

        $case = array();
        
        if(!empty($data['title'])){
            $case['title'] = strip_tags($data['title']);
        }
        if(isset($data['photo'])){
            $case['photo'] = htmlspecialchars_decode($data['photo']);
        }
        if(isset($data['sort'])){
            $case['sort'] = (int)$data['sort'];
        }else{
            $case['sort'] = 1;
        }
        $case['company_id'] =(int)$company_id;
        $case['date_added'] =date('Y-m-d H:i:s');
        
        if(isset($data['case_id']) && $data['case_id']){
            $this->db->update("company_case",array('case_id'=>$data['case_id']),$case);
        }else{
            $this->db->insert("company_case",$case);
        }      
    }

    public function getMember($member_id){
        return $this->db->fetch('company_member',array('one'=>true,'condition'=>array('member_id'=>$member_id,'company_id'=>$this->customer->isCompany())));
    }

    public function deleteMember($member_id){
        $this->db->delete('company_member',array('member_id'=>$member_id,'company_id'=>$this->customer->isCompany()));
        return true;
    }

    public function editMember($company_id,$data=array()){

        $member = array();
        
        if(!empty($data['name'])){
            $member['name'] = strip_tags($data['name']);
        }
        if(!empty($data['position'])){
            $member['position'] = strip_tags($data['position']);
        }
        if(isset($data['avatar'])){
            $member['avatar'] = htmlspecialchars_decode($data['avatar']);
        }
        if(isset($data['sort'])){
            $member['sort'] = (int)$data['sort'];
        }else{
            $member['sort'] = 1;
        }
        $member['company_id'] =(int)$company_id;
        $member['date_added'] =date('Y-m-d H:i:s');
        if(isset($data['member_id']) && $data['member_id']){
            $this->db->update("company_member",array('member_id'=>$data['member_id']),$member);
        }else{
            $this->db->insert("company_member",$member);
        }        
    }
    public function getFile($file_id){
        return $this->db->fetch('company_file',array('one'=>true,'condition'=>array('file_id'=>$file_id,'company_id'=>$this->customer->isCompany())));
    }

    public function deleteFile($file_id){
        $this->db->delete('company_file',array('file_id'=>$file_id,'company_id'=>$this->customer->isCompany()));
        return true;
    }
    
    public function editFile($company_id,$data=array()){

        $file = array();
        
        if(!empty($data['mode'])){
            $file['mode'] = strtolower($data['mode']);
        }

        if(isset($data['path'])){
            $file['path'] = htmlspecialchars_decode($data['path']);
        }
        if(isset($data['sort'])){
            $file['sort'] = (int)$data['sort'];
        }else{
            $file['sort'] = 1;
        }
        $file['company_id'] =(int)$company_id;
        $file['date_added'] =date('Y-m-d H:i:s');
        if(isset($data['file_id']) && $data['file_id']){
            $this->db->update("company_file",array('file_id'=>$data['file_id']),$file);
        }else{
            $this->db->insert("company_file",$file);
        }        
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
            if($cid){
                $implode[] = " AND c.company_id IN (" . implode(",", $cid) . ")";
            }else{
                return array();
            }
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
            if($cid){
                $implode[] = " AND c.company_id IN (" . implode(",", $cid) . ")";
            }else{
                return 0;
            }
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
    public function getCompanyGroup($company_id){
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."company_group WHERE group_id = '".(int)$company_id."' AND `status` = '1' AND `show` = '1' ORDER BY sort_order ASC");

        return $query->row;
    }
    public function getCompany($company_id){
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."company WHERE company_id = '".(int)$company_id."' AND status = '1'");

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

    public function getCompanyModule($company_id,$sort=1){
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."company_module WHERE company_id = '".(int)$company_id."' AND status = '1'  AND sort = '".$sort."' ");

        return $query->row;
    }

    public function getCompanyModulesByCompanyId($company_id){
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."company_module WHERE company_id = '".(int)$company_id."' AND status = '1' ORDER BY sort ASC ");

        return $query->num_rows ? $query->rows : array();
    }

    public function getCompanyFilesByCompanyId($company_id){
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."company_file WHERE company_id = '".(int)$company_id."' ORDER BY sort ASC ,date_added DESC");

        return $query->num_rows ? $query->rows : array();
    }

    public function getCompanyFile($file_id,$company_id){
        $query = $this->db->query("SELECT * FROM ".DB_PREFIX."company_file WHERE file_id = '".(int)$file_id."' AND company_id = '".$company_id."' ORDER BY sort ASC ,date_added DESC");

        return $query->row;
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