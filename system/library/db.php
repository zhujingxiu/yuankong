<?php
class DB {
    private $db;

    public function __construct($driver, $hostname, $username, $password, $database) {
        $class = 'DB\\' . $driver;

        if (class_exists($class)) {
            $this->db = new $class($hostname, $username, $password, $database);
        } else {
            exit('Error: Could not load database driver ' . $driver . '!');
        }
    }

    public function query($sql) {
        return $this->db->query($sql);
    }

    public function escape($value) {
        return $this->db->escape($value);
    }

    public function countAffected() {
        return $this->db->countAffected();
    }

    public function getLastId() {
        return $this->db->getLastId();
    }

    public function fetch($table,$data=array(),$dump=false){
        if(!isset($data['simple']) || $data['simple']){
            $sql = array();
            $sql['select'] = "SELECT";

            //fields
            if(isset($data['field'])){
                if(is_array($data['field'])){
                    $sql['fields'] = implode(" , ", $data['field']);
                }else{
                    $sql['fields'] = trim($data['field']);
                }
            }else{
                $sql['fields'] = '*';
            }
            $sql['from'] = " FROM ".DB_PREFIX.trim($table);

            //table alias
            $sql['alias'] = isset($data['alias']) ? "AS ".trim($data['alias']) : "";

            //join
            /*
            $join = array(
                    array(
                        'mode' => 'left join',
                        'table' => 'table',
                        'alias' => 't',
                        'on' => 't.id = pri.tid' | array()
                    )
                )

            */
            if(isset($data['join']) && is_array($data['join'])){
                $join_sql = "";
                foreach ($data['join'] as $item) {
                    if($item['table'] && $item['on']){
                        if(!isset($item['mode'])){
                            $item['mode'] = 'left join';
                        }
                        $join_sql .= strtoupper($item['mode'])." `".DB_PREFIX.$item['table']."` AS ".$item['alias'];
                        if(is_array($item['on'])){
                            $join_sql .= " ON ( ".implode(" AND ", $item['on'])." ) " ;
                        }else{
                            $join_sql .= " ON ".$item['on']." ";
                        }
                    }
                }
                $sql['join'] = $join_sql;
            }

            //where
            $where = array();
            if(isset($data['condition'])){
                foreach ($data['condition'] as $key => $value) {
                    if(is_array($value)){
                        $value['logic'] = !isset($value['logic']) ? "eq" : trim($value['logic']);
                        $value['value'] = !isset($value['value']) ? "" : trim($value['value']);                     
                        if(!isset($value['alias'])){
                            if(isset($data['alias'])){
                                $value['alias'] = $data['alias'];
                            }else{
                                $value['alias'] = "";
                            }
                        }
                        $where[] = $this->_logic($key,$value['logic'],$value['value'],trim($value['alias']));
                    }else{
                        $where[] = (!empty($data['alias']) ? $data['alias']."." : '')."`".$key."` = '".$this->escape(trim($value))."'"; 
                    }
                    
                }
            }
            $sql['where'] = count($where) ? " WHERE ".implode(" AND ", $where) : '';

            //sort
            if(isset($data['sort'])){
                if(is_array($data['sort'])){
                    $sql['sort'] = " ORDER BY ".implode(",", $data['sort']);
                }else{
                    $sql['sort'] = " ORDER BY ".$data['sort'];
                }
            }

            //limit
            if(isset($data['limit'])){
                $sql['limit'] = " LIMIT ".(isset($data['start']) ? $data['start']." , " : "" ).$data['limit'];
            }
            $sql = implode(" ", $sql);
            if($dump){
                echo $sql;
            }
            $query = $this->query($sql);
            return isset($data['one']) && $data['one'] ? $query->row : $query->rows;
        }
    }

    public function insert($table,$data=array()){
        if(!empty($table)){
            $fields  = array();
            foreach ($data as $key => $value) {
                $fields[] = " `".$key."` = '".$this->escape(trim($value))."'";
            }
            $this->query("INSERT INTO ".DB_PREFIX.trim($table)." SET ".implode(",",$fields));
            return $this->getLastId();
        }
        return false;
    }

    public function update($table,$condition,$data=array()){
        if(!empty($table)){
            $fields  = array();
            foreach ($data as $key => $value) {
                $fields[] = " `".$key."` = '".$this->escape(trim($value))."'";
            }
            $where = array();
            foreach ($condition as $key => $value) {
                $where[] = " `".$key."` = '".$this->escape(trim($value))."'";
            }
            $wheresql = count($where) ? " WHERE ".implode(" AND ", $where) : '';
            $this->query("UPDATE ".DB_PREFIX.trim($table)." SET ".implode(",",$fields).$wheresql);
            return $this->countAffected();
        }
        return false;
    }

    public function delete($table,$condition){
        if(!empty($table) && is_array($condition) && count($condition)){
            $where = array();
            foreach ($condition as $key => $value) {
                $where[] = " `".$key."` = '".$this->escape(trim($value))."'";
            }
            $wheresql = count($where) ? " WHERE ".implode(" AND ", $where) : '';
            $this->query("DELETE FROM ".DB_PREFIX.trim($table).$wheresql);
        }
        return false;
    }

    private function _logic($field,$operator,$value='',$alias=''){
        $condition = '';
        if(empty($operator)||empty($field)){
            return false;
        }

        switch (strtoupper(trim($operator))){
            case 'EQ':
                $condition = "= '".$this->db->escape($value)."'";
                break;
            case 'NEQ':
                $condition = "<> '".$this->db->escape($value)."'";
                break;
            case 'LIKE':
                $condition = "LIKE '%".$this->db->escape($value)."%'";
                break;
            case 'LLIKE':
                $condition = "LIKE '".$this->db->escape($value)."%'";
                break;
            case 'RLIKE':
                $condition = "LIKE '%".$this->db->escape($value)."'";
                break;
            case 'GT':
                $condition = "> '".$this->db->escape($value)."'";
                break;
            case 'LT':
                $condition = "< '".$this->db->escape($value)."'";
                break;
            case 'GTE':
                $condition = ">= '".$this->db->escape($value)."'";
                break;
            case 'LTE':
                $condition = "<= '".$this->db->escape($value)."'";
                break;
            case 'IN':
                $condition = "IN (".$this->db->escape($value).")";
                break;
            case 'BT':
                $condition = "BETWEEN ".$value;
            case 'NOPARSE':
                return $value;
                break;
        }
        return (empty($alias) ? "" : $alias.".")."`".$field."` ".$condition;
    }
}
