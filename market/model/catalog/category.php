<?php
class ModelCatalogCategory extends Model {
	public function getCategory($category_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id)  WHERE c.category_id = '" . (int)$category_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "'  AND c.status = '1'");
		
		return $query->row;
	}
	
	public function getCategories($parent_id = 0) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id)  WHERE c.parent_id = '" . (int)$parent_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "'   AND c.status = '1' ORDER BY c.sort_order, LCASE(cd.name)");

		return $query->rows;
	}
	
					
	public function getTotalCategoriesByCategoryId($parent_id = 0) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "category c  WHERE c.parent_id = '" . (int)$parent_id . "'  AND c.status = '1'");
		
		return $query->row['total'];
	}

	public function getSubCategoriesByPath($category_id = 0) {
		$query = $this->db->query("SELECT c.category_id,cd.name FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "category c ON (c.category_id = cp.category_id) LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id)  WHERE cp.path_id = '" . (int)$category_id . "'  AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c.status = '1' AND c.category_id != '".$category_id."' ");
		
		return $query->num_rows ? $query->rows : array();
	}
}
