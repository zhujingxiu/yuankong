<?php  
class ControllerModuleYkproject extends Controller {
    protected function index( $setting ) {
    
        static $module = 0;
        
        $this->data['setting'] = $setting;

        $this->data['module'] = $module++;
                        
        $this->template = $this->config->get('config_template') . '/template/module/ykproject.tpl';
        
        $this->render();
    }
}
