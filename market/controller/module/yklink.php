<?php  
class ControllerModuleYklink extends Controller {
    protected function index( $setting ) {
    
        static $module = 0;
        
        $this->data['setting'] = $setting;
        $this->load->model('catalog/link');
        $this->data['links'] = $this->model_catalog_link->getLinks($setting['limit']);
        $this->data['module'] = $module++;
                        
        $this->template = $this->config->get('config_template') . '/template/module/yklink.tpl';
        
        $this->render();
    }
}
