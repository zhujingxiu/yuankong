<?php  
class ControllerModuleYkwiki extends Controller {
    protected function index( $setting ) {
        $this->load->model('module/ykmodule');
        static $module = 0;

        $this->data['setting'] = $setting;  

        $this->data['title'] = $setting['title'][$this->config->get('config_language_id')];
        $this->data['wiki'] = array();
        if(isset($setting['category_tabs'])){
            if(isset($setting['sort'])){
                sort($setting['sort']);
                $groups = array();
                foreach ($setting['sort'] as $key => $value) {
                    $groups[] = $setting['category_tabs'][$key];
                }
            }else{
                $groups = $setting['category_tabs'];
            }
            foreach ($groups as $key => $gid) {
                if($gid){
                    $group = $this->model_module_ykmodule->getGroup($gid);
                    $title = !empty($group['name']) ? $group['name'] : $this->language->get('text_unknown');
                    $link = $this->url->link('information/wiki','wiki_group='.$gid,'SSL');
                }else{
                    $title = $this->language->get('text_wiki_help');
                    $link = $this->url->link('information/help','','SSL');
                }
                $config =  array(
                    'group_id' => $gid,
                    'limit'     => isset($setting['limit'][$key]) ? $setting['limit'][$key] : 5,
                );
                $_wiki = $this->model_module_ykmodule->getWiki($config);
                foreach ($_wiki as $i => $item) {
                    if($gid){
                        $_wiki[$i]['link'] = $this->url->link('information/wiki/info','wiki_group='.$item['group_id'].'&wiki_id='.$item['wiki_id'],'SSL');
                    }else{
                        $_wiki[$i]['link'] = $this->url->link('information/help','help_id='.$item['help_id'],'SSL');
                    }
                }
                $offset = isset($setting['sort'][$key]) ? (int)$setting['sort'][$key] : 0;
                $data = array(
                    'data' => $_wiki,
                    'icon' => isset($setting['image'][$key]) ? $setting['image'][$key] : '',
                    'title' => $title,
                    'link' => $link
                );
                if(isset($this->data['wiki']['top']) && count($this->data['wiki']['top'])>2){
                    $this->data['wiki']['bottom'][] = $data;
                }else{
                    $this->data['wiki']['top'][] = $data;
                }
            }
        }

        $this->data['module'] = $module++;
        $this->data['text_more'] = $this->language->get('text_more');
        $this->template = $this->config->get('config_template') . '/template/module/ykwiki.tpl';
        
        $this->render();
    }
}
