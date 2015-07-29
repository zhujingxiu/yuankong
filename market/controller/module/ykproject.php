<?php  
class ControllerModuleYkproject extends Controller {
    protected function index( $setting ) {
    
        static $module = 0;
        
        $this->data['setting'] = $setting;

        $this->data['module'] = $module++;
        $this->data['action'] = $this->url->link('service/project/apply','','SSL');
        $this->data['redirect'] = $this->url->link('common/home','','SSL');
        $this->load->model('module/ykmodule');
        $this->data['groups'] = $this->model_module_ykmodule->getProjectGroups();

        $this->template = $this->config->get('config_template') . '/template/module/ykproject.tpl';
        
        $this->render();
    }
}
