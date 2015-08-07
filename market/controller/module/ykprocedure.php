<?php  
class ControllerModuleYkprocedure extends Controller {
    protected function index( $setting ) {
    
        static $module = 0;
        
        $this->data['setting'] = $setting;

        $this->data['module'] = $module++;

        $this->data['prefix'] = $this->url->link('service/project','','SSL');
        $this->data['design'] = $this->url->link('service/project','group=design','SSL');
        $this->data['project'] = $this->url->link('service/project','group=project','SSL');
        $this->data['check'] = $this->url->link('service/project','group=check','SSL');
        $this->data['approve'] = $this->url->link('service/project','group=approve','SSL');
        $this->data['maintenance'] = $this->url->link('service/project','group=maintenance','SSL');
        $this->data['trusteeship'] = $this->url->link('service/project','group=trusteeship','SSL');
        $this->data['train'] = $this->url->link('service/project','group=train','SSL');
        $this->data['guarantee'] = $this->url->link('service/project','group=guarantee','SSL');
                        
        $this->template = $this->config->get('config_template') . '/template/module/ykprocedure.tpl';
        
        $this->render();
    }
}
