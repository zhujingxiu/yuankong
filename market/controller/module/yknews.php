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
            if(!empty($value['wiki_id'])){
                $news[$k]['link'] = $this->url->link('information/wiki/info','wiki_group='.$value['group_id'].'&wiki_id='.$value['wiki_id'],'SSL');
            }
        }
        $this->data['newses'] = $news;
        $this->data['module'] = $module++;
        $this->data['text_more'] = $this->language->get('text_more');
        $this->data['news'] = $this->url->link('information/wiki','','SSL');
        $this->data['assistant'] = $this->url->link('service/assistant','','SSL');
        $this->data['expert'] = $this->url->link('service/assistant/expert','','SSL');
        $this->data['quoted_price'] = $this->url->link('service/assistant/quoted_price','','SSL');
        $this->data['bidding'] = $this->url->link('service/assistant/bidding','','SSL');
        $this->data['lecture'] = $this->url->link('service/assistant/lecture','','SSL');
        $this->template = $this->config->get('config_template') . '/template/module/yknews.tpl';
        
        $this->render();
    }
}
