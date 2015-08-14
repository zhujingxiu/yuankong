<?php  
class ControllerModuleYkconsult extends Controller {
    protected function index() {
        $this->language->load('module/ykconsult');
        $this->load->model('catalog/information');

        $this->data['helps'] = $this->model_catalog_information->getTopHelps();

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/ykconsult.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/module/ykconsult.tpl';
        } else {
            $this->template = 'default/template/module/ykconsult.tpl';
        }
        
        $this->render();
    }
}