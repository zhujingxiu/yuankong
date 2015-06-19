<?php
class ModelCatalogLink extends Model {

    
    public function getLinks($limit=10) {

        return $this->db->fetch('link',array('limit'=>$limit,'sort'=>' sort_order '));
    }
    
}