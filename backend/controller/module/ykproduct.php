<?php
class ControllerModuleYkproduct extends Controller {
    private $error = array(); 
    
    public function index() {   
        
        $this->language->load('module/ykproduct');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('setting/setting');
        $this->load->model('tool/image');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

            $this->model_setting_setting->editSetting('ykproduct', $this->request->post);     
                    
            $this->session->data['success'] = $this->language->get('text_success');

            $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));

        }
                
        $this->data['heading_title'] = $this->language->get('heading_title');
        $this->data['text_image_manager'] = $this->language->get('text_image_manager');
        $this->data['text_browse'] = $this->language->get('text_browse');
        $this->data['text_clear'] = $this->language->get('text_clear'); 
        $this->data['no_image'] = '';

        $this->data['text_enabled'] = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');
        $this->data['text_none'] = $this->language->get('text_none');
        $this->data['text_content_top'] = $this->language->get('text_content_top');
        $this->data['text_content_bottom'] = $this->language->get('text_content_bottom');       
        $this->data['text_column_left'] = $this->language->get('text_column_left');
        $this->data['text_column_right'] = $this->language->get('text_column_right');
        $this->data['text_add_category'] = $this->language->get('text_add_category');
        $this->data['text_add_product'] = $this->language->get('text_add_product');
        $this->data['text_add_banner'] = $this->language->get('text_add_banner');

        $this->data['entry_title'] = $this->language->get('entry_title');
        $this->data['entry_title_class'] = $this->language->get('entry_title_class');
        $this->data['entry_tabs'] = $this->language->get('entry_tabs');
        $this->data['entry_banner'] = $this->language->get('entry_banner');
        $this->data['entry_product'] = $this->language->get('entry_product');
        $this->data['entry_limit'] = $this->language->get('entry_limit'); 
        $this->data['entry_link'] = $this->language->get('entry_link'); 
        $this->data['entry_price'] = $this->language->get('entry_price'); 
        $this->data['entry_subtitle'] = $this->language->get('entry_subtitle'); 
        $this->data['entry_icon_image'] = $this->language->get('entry_icon_image'); 
        $this->data['entry_layout'] = $this->language->get('entry_layout');
        $this->data['entry_position'] = $this->language->get('entry_position');
        $this->data['entry_status'] = $this->language->get('entry_status');
        $this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
        $this->data['entry_category'] = $this->language->get( 'entry_category' );

        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');
        $this->data['button_add_module'] = $this->language->get('button_add_module');
        $this->data['button_remove'] = $this->language->get('button_remove');
        $this->data['button_add'] = $this->language->get('button_add');
        
        $this->load->model('localisation/language');
        $this->data['tab_module'] = $this->language->get('tab_module');
        $this->data['languages'] = $this->model_localisation_language->getLanguages();
        $this->data['token'] = $this->session->data['token'];
        
        
        $this->data['positions'] = array( 
              'mainmenu',
              'slideshow',
              'promotion',
              'showcase',
              'content_top',
              'column_left',
              'column_right',
              'content_bottom',
              'mass_bottom',
              'footer_top',
              'footer_center',
              'footer_bottom'
        );
        
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }
        
        if (isset($this->error['dimension'])) {
            $this->data['error_dimension'] = $this->error['dimension'];
        } else {
            $this->data['error_dimension'] = array();
        }
        
        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_module'),
            'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
        
        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('module/ykproduct', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
        
        $this->data['action'] = $this->url->link('module/ykproduct', 'token=' . $this->session->data['token'], 'SSL');
        
        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
        
        $this->data['modules'] = array();
        
        if (isset($this->request->post['ykproduct_module'])) {
            $this->data['modules'] = $this->request->post['ykproduct_module'];
        } elseif ($this->config->get('ykproduct_module')) { 
            $this->data['modules'] = $this->config->get('ykproduct_module');
        }   

        $this->load->model('catalog/product');
        foreach ($this->data['modules'] as $key => $module) {
            if(isset($module['category_tabs']['category']) && is_array($module['category_tabs']['category'])){
                foreach ($module['category_tabs']['category'] as $i => $_category_id) { 
                    $_category = $this->model_catalog_product->getCategoryName($_category_id); 
                    $this->data['modules'][$key]['category_tabs']['data'][] = array(
                        'category_id' => $_category_id,
                        'limit'     => isset($module['category_tabs']['limit'][$i]) ? $module['category_tabs']['limit'][$i] : 5,
                        'sort'      => isset($module['category_tabs']['sort'][$i]) ? $module['category_tabs']['sort'][$i] : 0,
                        'name'      => empty($_category['category_name']) ? '' : $_category['category_name']
                    );
                }
            }
            if(isset($module['product_tabs']['product']) && is_array($module['product_tabs']['product'])){
                foreach ($module['product_tabs']['product'] as $j => $_product_id) { 
                    $_product = $this->model_catalog_product->getProduct($_product_id);

                    $product_category_data = array();
                    $categories = $this->model_catalog_product->getProductCategories($_product_id);
                    foreach ($categories as $_category_id) {
                        $_category = $this->model_catalog_product->getCategoryName($_category_id);
                        if(!empty($_category['category_name'])){
                            $product_category_data[] = $_category['category_name'];
                        }
                    } 
                    $this->data['modules'][$key]['product_tabs']['data'][] = array(
                        'product_id' => $_product_id,
                        'subtitle'  => empty($_product['subtitle']) ? '' : $_product['subtitle'] ,
                        'price'     => isset($_product['price']) ? $_product['price'] : '',
                        'sort'      => isset($module['product_tabs']['sort'][$j]) ? $module['product_tabs']['sort'][$j] : 0,
                        'image'     => !empty($module['product_tabs']['image'][$j]) ? $module['product_tabs']['image'][$j] : $_product['image'],
                        'name'      => current($product_category_data).'<br>'.(empty($_product['name']) ? '' : $_product['name'])
                    );
                }
            }
            if(isset($module['banner_tabs']['image']) && is_array($module['banner_tabs']['image'])){
                foreach ($module['banner_tabs']['image'] as $n => $_banner_id) { 

                    $this->data['modules'][$key]['banner_tabs']['data'][] = array(
                        'sort'      => isset($module['banner_tabs']['sort'][$n]) ? $module['banner_tabs']['sort'][$n] : 0,
                        'link'      => isset($module['banner_tabs']['link'][$n]) ? $module['banner_tabs']['link'][$n] : 0,
                        'image'     => !empty($module['banner_tabs']['image'][$n]) ? $module['banner_tabs']['image'][$n] : $_banner['image'],
                    );
                }
            }
        }
        $this->load->model('design/layout');
echo "<pre>";
print_r( $this->data['modules']);
echo "</pre>";
        $this->data['layouts'] = array();
        $this->data['layouts'][] = array('layout_id'=>99999, 'name' => $this->language->get('all_page') );
        
        $this->data['layouts'] = array_merge($this->data['layouts'],$this->model_design_layout->getLayouts());
        $this->load->model('catalog/category');
        $this->data['top_categories'] = $this->model_catalog_category->getSelectionCategories(null);

        $this->template = 'module/ykproduct.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
                
        $this->response->setOutput($this->render());
    }
    
    protected function validate() {
        if (!$this->user->hasPermission('modify', 'module/ykproduct')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
          
                        
        if (!$this->error) {
            return true;
        } else {
            return false;
        }   
    }

    public function selections(){
        $this->load->model('catalog/category');
        $id = isset($this->request->get['cid']) ? (int)$this->request->get['cid'] : null;
        $json = array('status'=>0);
        $category = $this->model_catalog_category->getSelectionCategories($id);
        $product = $this->model_catalog_category->getSelectionProducts($id);

        if( (is_array($category) && count($category)) || (is_array($product) && count($product))){
            $json = array('status'=>1,'category'=>$category,'product'=>$product);
        }       
        $this->response->setOutput(json_encode($json));
    }
}