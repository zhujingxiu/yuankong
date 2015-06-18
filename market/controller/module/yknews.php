<?php  
class ControllerModuleYknews extends Controller {
    protected function index( $setting ) {
        $this->load->model('module/ykmodule');
        static $module = 0;

        $this->data['setting'] = $setting;       
        $this->data['title'] = $setting['title'];
        $this->data['first_class'] = $setting['first_class'];
        $news = $this->model_module_ykmodule->getNewses($setting['group_id'],$setting['limit']);
        foreach ($news as $k => $value) {
            if(!empty($value['news_id'])){
                $news[$k]['link'] = $this->url->link('catelog/news','news_id='.$value['news_id'],'SSL');
            }
        }
        $this->data['newses'] = $news;
        $this->data['module'] = $module++;
        $this->data['text_more'] = $this->language->get('text_more');
        $this->data['news'] = $this->url->link('catelog/news','','SSL');
        $this->template = $this->config->get('config_template') . '/template/module/yknews.tpl';
        
        $this->render();
    }
}
