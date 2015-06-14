<?php  
class ControllerModuleYkcase extends Controller {
    protected function index( $setting ) {
        $this->load->model('module/ykmodule');
        static $module = 0;

        $this->data['setting'] = $setting;       
        $this->data['title'] = $setting['title'];
        $this->data['first_class'] = $setting['first_class'];
        $case = $this->model_module_ykmodule->getCases($setting['limit']);
        foreach ($case as $k => $value) {
            if(!empty($value['case_id'])){
                $case[$k]['link'] = $this->url->link('catelog/case','case_id='.$value['case_id'],'SSL');
            }
        }
        $this->data['casees'] = $case;
        $this->data['module'] = $module++;
        $this->data['text_more'] = $this->language->get('text_more');
        $this->data['text_more'] = $this->language->get('text_more');
        $this->data['case'] = $this->url->link('catelog/case','','SSL');
        $this->template = $this->config->get('config_template') . '/template/module/ykcase.tpl';
        
        $this->render();
    }
}
