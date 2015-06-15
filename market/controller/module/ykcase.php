<?php  
class ControllerModuleYkcase extends Controller {
    protected function index( $setting ) {
        $this->load->model('module/ykmodule');
        static $module = 0;

        $this->data['setting'] = $setting;       
        $this->data['title'] = $setting['title'];
        $case = $this->model_module_ykmodule->getCases($setting['limit']);
        $this->load->model('tool/image');

        foreach ($case as $k => $value) {
            if(file_exists(DIR_IMAGE . $value['cover'])){
                $image =  $value['cover'];
            }else{
                $image = 'no_image.jpg';
            }
            if(!empty($value['case_id'])){
                $case[$k]['thumb'] = $this->model_tool_image->resize($image, 150, 60);
                $case[$k]['link'] = $this->url->link('catelog/case','case_id='.$value['case_id'],'SSL');
            }
        }
        $this->data['cases'] = $case;
        $this->data['module'] = $module++;
        $this->data['text_more'] = $this->language->get('text_more');
        $this->data['text_more'] = $this->language->get('text_more');
        $this->data['case'] = $this->url->link('catelog/case','','SSL');
        $this->template = $this->config->get('config_template') . '/template/module/ykcase.tpl';
        
        $this->render();
    }
}
