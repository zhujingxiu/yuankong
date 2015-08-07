<?php 
class ModelSaleProjectGroup extends Model {
	public function addProjectGroup($data) {
		$fields = array(
			'name' => isset($data['name']) ? strip_tags(trim($data['name'])) : '',
			'keyword' => isset($data['keyword']) ? strtolower(strip_tags(trim($data['keyword']))) : '',
			'show' => isset($data['show']) ? (int)$data['show'] : 0,
			'remark' => isset($data['remark']) ? $data['remark'] : '',
			'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0
		);

		return $this->db->insert("project_group",$fields);
	}

	public function editProjectGroup($project_group_id, $data) {
		$fields = array(
			'name' => isset($data['name']) ? strip_tags(trim($data['name'])) : 0,
			'keyword' => isset($data['keyword']) ? strtolower(strip_tags(trim($data['keyword']))) : '',
			'show' => isset($data['show']) ? (int)$data['show'] : 0,
			'remark' => isset($data['remark']) ? $data['remark'] : '',
			'sort_order' => isset($data['sort_order']) ? (int)$data['sort_order'] : 0
		);

		return $this->db->update("project_group",array('group_id'=>$project_group_id),$fields);
	}
	
	public function deleteProjectGroup($project_group_id) {
		$this->db->delete("project_group",array('project_group_id' => (int)$project_group_id));
	}
		
	public function getProjectGroup($project_group_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "project_group WHERE group_id = '" . (int)$project_group_id . "'");
		
		return $query->row;
	}
		
	public function getProjectGroups($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "project_group pg  ";
			
		$sort_data = array(
			'pg.keyword',
			'pg.name',
			'pg.show',
			'pg.sort_order'
		);	
		
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY pg.group_id";	
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
	
	
	public function getTotalProjectGroups() {
      	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "project_group");
		
		return $query->row['total'];
	}	
}
