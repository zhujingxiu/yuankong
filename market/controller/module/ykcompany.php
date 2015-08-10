<?php  
class ControllerModuleYkcompany extends Controller {
    protected function index( $setting ) {
        $this->load->model('module/ykmodule');
        $this->load->language('module/ykcompany');
        static $module = 0;

        $this->data['setting'] = $setting;  

        $this->data['title'] = $setting['title'][$this->config->get('config_language_id')];
        $this->data['companies'] = array();
        if(isset($setting['category_tabs'])){
            if(isset($setting['sort'])){
                asort($setting['sort']);
                $groups = array();
                foreach ($setting['sort'] as $key => $value) {
                    $groups[] = $setting['category_tabs'][$key];
                }
            }else{
                $groups = $setting['category_tabs'];
            }
            foreach ($groups as $key => $gid) {
                 $title = $this->language->get('text_unknown');
                if($gid){
                    $group = $this->model_module_ykmodule->getGroup($gid,'company_group');

                    $title = !empty($group['name']) ? $group['name'] : $this->language->get('text_unknown');
                }
                $config =  array(
                    'group_id' => $gid,
                    'limit'     => isset($setting['limit'][$key]) ? $setting['limit'][$key] : 5,
                );
                $_company = $this->model_module_ykmodule->getCompanies($config);

                foreach ($_company as $i => $item) {                    
                    $_company[$i]['link'] = $this->url->link('account/company/info','company_id='.$item['company_id'],'SSL');
                }
                $offset = isset($setting['sort'][$key]) ? (int)$setting['sort'][$key] : 0;
                $data = array(
                    'data' => $_company,
                    'icon_class' => isset($setting['icon_class'][$key]) ? $setting['icon_class'][$key] : '',
                    'title' => $title,
                );
                $this->data['companies'][] = $data;
            }
        }

        $this->data['module'] = $module++;
        $lateast = $this->model_module_ykmodule->getCompanies(array('limit'=>$setting['lateast']));
        foreach ($lateast as $key => $item) {
            $lateast[$key]['link'] = $this->url->link('company/account/info','company_id='.$item['company_id'],'SSL');
        }
        $this->data['lateast'] = $lateast;
        $this->data['text_more'] = $this->language->get('text_more');
        $this->data['entry_name'] = $this->language->get('entry_name');
        $this->data['entry_telephone'] = $this->language->get('entry_telephone');
        $this->data['error_name'] = $this->language->get('error_name');
        $this->data['error_telephone'] = $this->language->get('error_telephone');
        $this->data['text_find'] = $this->language->get('text_find');
        $this->data['text_lateast'] = $this->language->get('text_lateast');
        $this->data['button_apply'] = $this->language->get('button_apply');
        $this->data['more'] = $this->url->link('company/account/list','','SSL');
        $this->data['action'] = $this->url->link('service/project/apply','','SSL');
        $this->template = $this->config->get('config_template') . '/template/module/ykcompany.tpl';
        
        $this->render();
    }
}
