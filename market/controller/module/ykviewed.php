<?php
class ControllerModuleYkviewed extends Controller {
	protected function index($setting) {
		$this->language->load('module/ykviewed');
		
      	$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['button_cart'] = $this->language->get('button_cart');
				
		$this->load->model('catalog/product');
		
		$this->load->model('tool/image');
		
		$this->data['additional_class'] = $setting['additional_class'];

		$this->data['products'] = array();
		
		
		if(isset($this->session->data['viewed']) && is_array($this->session->data['viewed'])){
			krsort($this->session->data['viewed']) ;
			foreach ($this->session->data['viewed'] as $key => $product_id) {
				if(count($this->data['products']) > $setting['limit']){
					continue;
				}
				$product_info = $this->model_catalog_product->getProduct($product_id);

				if ($product_info) { 
					if ($product_info['image']) {
						$image = $this->model_tool_image->resize($product_info['image'], $setting['image_width'], $setting['image_height']);
					} else {
						$image = false;
					}
								
					if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
						$price = $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = false;
					}
							
					if ((float)$product_info['special']) {
						$special = $this->currency->format($this->tax->calculate($product_info['special'], $product_info['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$special = false;
					}
					
					if ($this->config->get('config_review_status')) {
						$rating = $product_info['rating'];
					} else {
						$rating = false;
					}
					$category_id = $this->model_catalog_product->getProductCategories($product_id);
                	$path = $this->model_catalog_product->getCategoryPath($category_id);            
                	$path_param = empty($path) ? '' : '&path='.$path;	
					$this->data['products'][] = array(
						'product_id' => $product_info['product_id'],
						'thumb'   	 => $image,
						'name'    	 => $product_info['name'],
						'price'   	 => $price,
						'special' 	 => $special,
						'rating'     => $rating,
						'reviews'    => sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']),
						'href'    	 => $this->url->link('product/product', 'product_id=' . $product_info['product_id'].$path_param),
					);
				}else{
					unset($this->session->data['viewed'][$key]);
				}
			}
		}

		$this->template = $this->config->get('config_template') . '/template/module/ykviewed.tpl';

		$this->render();
	}
}