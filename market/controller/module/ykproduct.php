<?php  
class ControllerModuleYkproduct extends Controller {
    protected function index($setting) {
        static $module = 0;
        
        $this->load->model('catalog/product'); 
        $this->load->model('catalog/category'); 
        $this->load->model('tool/image');

        if( !isset($setting['category_tabs']) || !isset($setting['product_tabs']) || !isset($setting['banner_tabs']) ){
            return ;
        }
        $this->data['title'] = $setting['title'][$this->config->get('config_language_id')];
        $this->data['title_class']   = $setting['title_class'];
        $this->data['additional_class']   = $setting['additional_class'];

        sort($setting['category_tabs']['sort']);
        sort($setting['product_tabs']['sort']);
        sort($setting['banner_tabs']['sort']);
        $this->data['category'] = array();
        foreach ($setting['category_tabs']['sort'] as $i => $value) {
            
            $_category = $this->model_catalog_category->getCategory($setting['category_tabs']['category'][$i]); 
            if(!isset($_category['category_id']) || !isset($_category['name'])){
                continue;
            }
            $_sub_categories = $this->model_catalog_category->getSubCategoriesByPath($_category['category_id']);
            
            $category = array(
                'category_id'   => $_category['category_id'],
                'name'          => $_category['name'],
            );
            foreach ($_sub_categories as $item) {
                $path = $this->model_catalog_product->getCategoryPath($item['category_id']);
            
                $path_param = empty($path) ? '' : 'path='.$path;
                $sub_category = array(
                    'category_id'   => $item['category_id'],
                    'name'          => $item['name'],
                    'link'          => $this->url->link('product/category',$path_param,'SSL')
                );
                if(!isset($category['show']) || count($category['show']) < $setting['category_tabs']['limit'][$i]){
                    $category['show'][] = $sub_category;
                }
                $category['sub_categories'][] = $sub_category;
            }

            $this->data['category'][] = $category;
        }

        $this->data['product'] = array();
        foreach ($setting['product_tabs']['sort'] as $i => $value) {
            
            $_product = $this->model_catalog_product->getProduct($setting['product_tabs']['product'][$i]); 
            if(!isset($_product['product_id']) || !isset($_product['name'])){
                continue;
            }
            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $price = $this->currency->format($this->tax->calculate($_product['price'], $_product['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $price = false;
            }
            $image = empty($setting['product_tabs']['image'][$i]) ? $_product['image'] : $setting['product_tabs']['image'][$i];
            if(file_exists(TPL_IMG.$image)){
                $image = $this->model_tool_image->resize($image,155,155);
            }else{
                $image = $this->model_tool_image->resize("no_image.jpg",155,155);
            }

            $parent_id = $this->model_catalog_product->getProductCategories($_product['product_id']);
            
            $path = $this->model_catalog_product->getCategoryPath($parent_id);
            
            $path_param = empty($path) ? '' : '&path='.$path;
            $product = array(
                'product_id' => $_product['product_id'],
                'link'       => $this->url->link('product/product','product_id='.$_product['product_id'].$path_param,'SSL'),
                'name'       => $_product['name'],
                'subtitle'   => $_product['subtitle'],
                'price'      => $price,
                'image'      => $image
            );
            

            $this->data['product'][] = $product;
        }

        $this->data['banner'] = array();
        foreach ($setting['banner_tabs']['sort'] as $i => $value) {
            
            $link = empty($setting['banner_tabs']['link'][$i]) ? "" : $setting['banner_tabs']['link'][$i];
            $image = empty($setting['banner_tabs']['image'][$i]) ? false : $setting['banner_tabs']['image'][$i];
            if(file_exists(TPL_IMG.$image)){
                $image = TPL_IMG.$image;
            }else{
                $image = $this->model_tool_image->resize("no_image.jpg",198,420);
            }
            $banner = array(
                'link'      => $link,
                'image'      => $image
            );
            

            $this->data['banner'][] = $banner;
        }

        $this->data['module'] = $module++;                  
        $this->template = $this->config->get('config_template') . '/template/module/ykproduct.tpl';
        
        $this->render();
    }
    
    private function getProducts( $results, $setting ){
        $products = array();
        foreach ($results as $result) {
            if ($result['image']) {
                $image = $this->model_tool_image->resize($result['image'], $setting['width'], $setting['height']);
            } else {
                $image = false;
            }
                        
            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $price = false;
            }
                    
            if ((float)$result['special']) {
                $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $special = false;
            }
            
            if ($this->config->get('config_review_status')) {
                $rating = $result['rating'];
            } else {
                $rating = false;
            }
             
            $products[] = array(
                'product_id' => $result['product_id'],
                'thumb'      => $image,
                'name'       => $result['name'],
                'price'      => $price,
                'special'    => $special,
                'rating'     => $rating,
                'description'=> (html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')),
                'reviews'    => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
                'href'       => $this->url->link('product/product', 'product_id=' . $result['product_id']),
            );
        }
        return $products;
    }
}