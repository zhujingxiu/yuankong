<?php  
class ControllerModuleCategory extends Controller {
	protected function index($setting) {
		$this->language->load('module/category');
		$this->document->addScript('market/view/theme/yuankong/javascript/lib/fdj.js');
    	$this->data['heading_title'] = $this->language->get('heading_title');
		
		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}
		
		if (isset($parts[0])) {
			$this->data['category_id'] = $parts[0];
		} else {
			$this->data['category_id'] = 0;
		}
		
		if (isset($parts[1])) {
			$this->data['child_id'] = $parts[1];
		} else {
			$this->data['child_id'] = 0;
		}
							
		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$this->data['categories'] = array();

		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			$total = $this->model_catalog_product->getTotalProducts(array('filter_category_id' => $category['category_id']));

			$children_data = array();

			$children = $this->model_catalog_category->getCategories($category['category_id']);

			foreach ($children as $child) {

				$data = array(
					'filter_category_id'  => $child['category_id'],
					'filter_sub_category' => true
				);

				$product_total = $this->model_catalog_product->getTotalProducts($data);

				$_children_data = array();

				$_children = $this->model_catalog_category->getCategories($child['category_id']);

				foreach ($_children as $_child) {
					$data = array(
						'filter_category_id'  => $_child['category_id'],
						'filter_sub_category' => true
					);
					$_product_total = $this->model_catalog_product->getTotalProducts($data);

					

					$_children_data[] = array(
						'category_id' => $_child['category_id'],
						'name'        => $_child['name']. ($this->config->get('config_product_count') ? ' <em class="shopnum">(' . $_product_total . ')</em>' : ''),
						'href'        => $this->url->link('product/category', 'path=' . $_child['category_id'] . '_' . $_child['category_id'])	
					);
				}

				$total += $product_total;

				$children_data[] = array(
					'category_id' => $child['category_id'],
					'name'        => $child['name'] . ($this->config->get('config_product_count') ? ' <em class="shopnum">(' . $product_total . ')</em>' : ''),
					'children'    => $_children_data,
					'href'        => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])	
				);		
			}

			$this->data['categories'][] = array(
				'category_id' => $category['category_id'],
				'name'        => '<b>'.$category['name'].'</b>' . ($this->config->get('config_product_count') ? ' <em class="shopnum">(' . $total . ')</em>' : ''),
				'children'    => $children_data,
				'href'        => $this->url->link('product/category', 'path=' . $category['category_id'])
			);	
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/category.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/category.tpl';
		} else {
			$this->template = 'default/template/module/category.tpl';
		}
		
		$this->render();
  	}
}