<?php  
class ControllerModuleWiki extends Controller {
    protected function index( $setting ) {
    	$this->load->language('module/wiki');
    
        static $module = 0;
        
        $this->data['setting'] = $setting;
        $this->data['heading_title'] = $setting['title'];
        $this->load->model('module/ykmodule');
        $this->data['groups_information'] = $this->model_module_ykmodule->getWikiGroups(array('tag'=>1));
        foreach ($this->data['groups_information'] as $key => $item) {
        	$this->data['groups_information'][$key]['link'] = $this->url->link('information/wiki','wiki_group='.$item['group_id'],'SSL');
        }
        $this->data['groups_school'] = $this->model_module_ykmodule->getWikiGroups(array('tag'=>2));
        foreach ($this->data['groups_school'] as $key => $item) {
        	$this->data['groups_school'][$key]['link'] = $this->url->link('information/wiki','wiki_group='.$item['group_id'],'SSL');
        }

        $this->data['group'] = isset($this->request->get['wiki_group']) ? (int)$this->request->get['wiki_group'] : false;
        $this->data['module'] = $module++;

        $this->data['text_tag_information'] = $this->language->get('text_tag_information');
        $this->data['text_tag_school'] = $this->language->get('text_tag_school');
        $this->data['text_wiki_help'] = $this->language->get('text_wiki_help');

        $this->data['wiki_help'] = $this->url->link('wiki/help','','');
                        
        $this->template = $this->config->get('config_template') . '/template/module/wiki.tpl';
        
        $this->render();
    }
}