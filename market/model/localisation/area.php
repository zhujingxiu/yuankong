<?php
class ModelLocalisationArea extends Model {
    public function getAreas() {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "area WHERE  status = '1' ORDER BY sort");
        
        return $query->rows;
    }       
    
}
