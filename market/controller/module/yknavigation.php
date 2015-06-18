<?php
class ControllerModuleYknavigation extends Controller {

    protected function index($setting) {
        static $module = 0;
        
        $this->load->model('tool/image');
        

        $navigator = array();
        foreach ($setting['navigator'] as $k => $item) {
            $navigator[] = array(
                'link'  => $this->url->link(trim($item['route']),trim($item['param']),'SSL'),
                'title' => truncate_string($item['title']),
                'icon' => $item['icon'],
                'selected' => $item['selected'],
            );
        }
     
        $this->data['navgatiors'] = $navigator;
        $this->data['module'] = $module++;
        
        $this->data['nav_img'] = TPL_IMG."navad.jpg";
        $this->template = $this->config->get('config_template') . '/template/module/yknavigation.tpl';
        
        $this->render();
    }
}