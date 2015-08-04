<?php
class ControllerModuleYkliked extends Controller {
    protected function index($setting) {
        $this->language->load('module/ykliked');
        
        $this->data['heading_title'] = $this->language->get('heading_title');
        
        $this->data['button_cart'] = $this->language->get('button_cart');
                
        $this->load->model('catalog/product');
        
        $this->load->model('tool/image');

        $this->data['additional_class'] = $setting['additional_class'];
        $liked = array();
        $this->data['products'] = array();
        if($this->cart->countProducts()){
            foreach ($this->cart->getProducts() as $product) {
                $relateds = $this->model_catalog_product->getProductRelated($product['product_id']);
                if($relateds){
                    foreach ($relateds as $item) {
                        $liked[] = $item['product_id'];
                    }
                }else{
                    $category_id = $this->model_catalog_product->getProductCategories($product['product_id']);
                    if($category_id){
                        $category_data = $this->model_catalog_product->getCategoryRelated($category_id);
                        if($category_data){
                            foreach ($category_data as $item) {
                                $filter = array(
                                    'category_id' => $item['category_id'],
                                    'not_ids' => $this->cart->getProductIds()
                                );
                                $tmp = $this->model_catalog_product->getLikedProducts($filter);
                                foreach ($tmp as $item) {
                                    $liked[] = $item['product_id'];
                                }
                            }
                        }
                    }
                }
            }
        }

        if(count($liked)<5){
            $products = explode(',', $this->config->get('featured_product'));       

            if (empty($setting['limit'])) {
                $setting['limit'] = 5-count($liked) ;
            }
            
            $products = array_slice($products, 0, (int)$setting['limit']);
            $liked = array_merge($liked,$products);
        }
        $liked = array_unique($liked);
        if($liked){
            foreach ($liked as $product_id) {
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
                        'thumb'      => $image,
                        'name'       => $product_info['name'],
                        'price'      => $price,
                        'special'    => $special,
                        'rating'     => $rating,
                        'reviews'    => sprintf($this->language->get('text_reviews'), (int)$product_info['reviews']),
                        'href'       => $this->url->link('product/product', 'product_id=' . $product_info['product_id'].$path_param),
                    );
                }
            }
        }

         $this->data['products'] = array_slice( $this->data['products'], 0,5);

        $this->template = $this->config->get('config_template') . '/template/module/ykliked.tpl';

        $this->render();
    }
}