<?php  
class ControllerModuleYkwiki extends Controller {
    protected function index( $setting ) {
        $this->load->model('module/ykmodule');
        static $module = 0;

        $this->data['setting'] = $setting;  
 
        $this->data['title'] = $setting['title'];
        $this->data['wiki'] = array();
        if(isset($setting['category_tabs'])){

            foreach ($setting['category_tabs'] as $key => $value) {
                $config =  array(
                    'group_id' => $value,
                    'limit'     => isset($setting['limit'][$key]) ? $setting['limit'][$key] : 5,
                )
                $_wiki = $this->model_module_ykmodule->getWiki($config);
            }
        }
        
        $this->load->model('tool/image');


        
        $this->data['module'] = $module++;
        $this->data['text_more'] = $this->language->get('text_more');
        $this->data['text_more'] = $this->language->get('text_more');
        $this->data['case'] = $this->url->link('catelog/case','','SSL');
        $this->template = $this->config->get('config_template') . '/template/module/ykwiki.tpl';
        
        $this->render();
    }
}
