<?php
class ControllerModuleYknavigation extends Controller {
    private $error = array(); 
    
    public function index() {   
        $this->language->load('module/yknavigation');

        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('setting/setting');
                
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('yknavigation', $this->request->post);        
                    
            $this->session->data['success'] = $this->language->get('text_success');
                        
            $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
        }
                
        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_enabled'] = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');
        $this->data['text_yes'] = $this->language->get('text_yes');
        $this->data['text_no'] = $this->language->get('text_no');
        $this->data['text_content_top'] = $this->language->get('text_content_top');
        $this->data['text_content_bottom'] = $this->language->get('text_content_bottom');       
        $this->data['text_column_left'] = $this->language->get('text_column_left');
        $this->data['text_column_right'] = $this->language->get('text_column_right');

        $this->data['entry_title'] = $this->language->get('entry_title');
        $this->data['entry_selected'] = $this->language->get('entry_selected');
        $this->data['entry_route'] = $this->language->get('entry_route');
        $this->data['entry_param'] = $this->language->get('entry_param');
        $this->data['entry_layout'] = $this->language->get('entry_layout');
        $this->data['entry_position'] = $this->language->get('entry_position');
        $this->data['entry_status'] = $this->language->get('entry_status');
        $this->data['entry_icon'] = $this->language->get('entry_icon');
        $this->data['entry_additional_class'] = $this->language->get('entry_additional_class');
        $this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
        
        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');
        $this->data['button_add_module'] = $this->language->get('button_add_module');
        $this->data['button_remove'] = $this->language->get('button_remove');
        
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_module'),
            'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
        
        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('module/yknavigation', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
        
        $this->data['action'] = $this->url->link('module/yknavigation', 'token=' . $this->session->data['token'], 'SSL');
        
        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

        $this->data['positions'] = array( 
            'mainmenu',
            'slideshow',
            'showcase',
            'promotion',
            'content_top',
            'column_left',
            'column_right',
            'content_bottom',
            'mass_bottom',
            'footer_top',
            'footer_center',
            'footer_bottom'
        );
        
        $this->data['modules'] = array();
        
        if (isset($this->request->post['yknavigation_module'])) {
            $this->data['modules'] = $this->request->post['yknavigation_module'];
        } elseif ($this->config->get('yknavigation_module')) { 
            $this->data['modules'] = $this->config->get('yknavigation_module');
        }   

        $this->data['module'] = array(
            'layout_id'=> isset($this->data['modules']['layout_id']) ? $this->data['modules']['layout_id'] : '',
            'position'=> isset($this->data['modules']['position']) ? $this->data['modules']['position'] : '',
            'status'=> isset($this->data['modules']['status']) ? $this->data['modules']['status'] : 1,
            'sort_order'=> isset($this->data['modules']['sort_order']) ? $this->data['modules']['sort_order'] : 0
        );

        $this->load->model('design/layout');
        $this->data['layouts'][] = array('layout_id'=>99999, 'name' => $this->language->get('all_page') );
        
        $this->data['layouts'] = array_merge($this->data['layouts'],$this->model_design_layout->getLayouts());

        $this->template = 'module/yknavigation.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
                
        $this->response->setOutput($this->render());
    }
    
    private function validate() {
        if (!$this->user->hasPermission('modify', 'module/yknavigation')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        if (!$this->error) {
            return true;
        } else {
            return false;
        }   
    }
    

}