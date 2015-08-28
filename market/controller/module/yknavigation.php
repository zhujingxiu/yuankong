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
        
        $this->data['nav_img'] = TPL_IMG."navad.png";
        if (isset($this->request->get['route'])) {
            $route = (string)$this->request->get['route'];
        } else {
            $route = 'common/home';
        }

        $part = explode("/", $route);
        
        $this->data['container_class'] = "w";
        if(isset($part[0]) && $part[0] =='account'){
            $this->data['container_class'] = "register-w";
        }
        $keyword = $part[0].'/'.$part[1];
        if($keyword == 'product/product'){
            $keyword = 'product/category';
        }
        if($keyword == 'service/project'){
            $group = isset($this->request->get['group']) ? strtolower(trim($this->request->get['group'])) : false ;
            if($group && in_array($group,array('design','train'))){
                $keyword = 'group='.$group;
            }
        }
        $this->data['keyword'] = $keyword;
        $this->data['commonweal'] = $this->url->link('service/commonweal','','SSL');
        $this->template = $this->config->get('config_template') . '/template/module/yknavigation.tpl';
        
        $this->render();
    }
}