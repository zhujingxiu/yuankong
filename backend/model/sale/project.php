<?php
class ModelSaleProject extends Model {
	public function addProject($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "project SET status = '" . (int)$data['status'] . "', user_id = '" . (int)$data['user_id'] . "'");

		$project_id = $this->db->getLastId();

		
	}

	public function editProject($project_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "project SET status = '" . (int)$data['status'] . "', user_id = '" . (int)$data['user_id'] . "' WHERE project_id = '" . (int)$project_id . "'");	
	}
	public function changeProjectStatus($project_id, $status) {
		$this->db->query("UPDATE " . DB_PREFIX . "project SET status = '" . (int)$status . "' , date_modified = NOW() WHERE project_id = '" . (int)$project_id . "'");
		
	}
	public function deleteProject($project_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "project WHERE project_id = '" . (int)$project_id . "'");
		
	}

	public function getProject($project_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "project WHERE project_id = '" . (int)$project_id . "'");

		return $query->row;
	}

	public function getProjects($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "project p  ";
		if(isset($data['tab'])){
			switch ($data['tab']) {
				case 'undo':
					$sql .= " WHERE status = 1 ";
					break;
				
				case 'doing':
					$sql .= " WHERE status = 2 ";
					break;
				case 'done':
					$sql .= " WHERE status = 3 ";
					break;
			}
			
		}
		$sort_data = array(
			'p.project_sn',
			'p.date_modified'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY p.date_modified";
		}

		if (isset($data['order']) && ($data['order'] == 'ASC')) {
			$sql .= " ASC";
		} else {
			$sql .= " DESC";
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

	public function getTotalProjects($data=array()) {
		$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "project";
		if(isset($data['tab'])){
			switch ($data['tab']) {
				case 'undo':
					$sql .= " WHERE status = 1 ";
					break;
				
				case 'doing':
					$sql .= " WHERE status = 2 ";
					break;
				case 'done':
					$sql .= " WHERE status = 3 ";
					break;
			}
			
		}
		$query = $this->db->query($sql);

		return $query->row['total'];
	}
}