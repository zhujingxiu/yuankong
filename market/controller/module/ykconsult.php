<?php  
class ControllerModuleYkconsult extends Controller {
    protected function index() {
        $this->language->load('module/ykconsult');
        $this->load->model('catalog/information');

        $helps = $this->model_catalog_information->getTopHelps();
        foreach ($helps as $item) {
            $item['link'] = $this->url->link('information/wiki/help','wiki_group=help&help_id='.$item['help_id'],'SSL');
            $this->data['helps'][] = $item;
        }
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/ykconsult.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/module/ykconsult.tpl';
        } else {
            $this->template = 'default/template/module/ykconsult.tpl';
        }
        
        $this->render();
    }
}