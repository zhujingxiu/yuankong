<?php
class ControllerModuleYkcompany extends Controller {
    private $error = array(); 
    
    public function index() {   
        
        $this->language->load('module/ykcompany');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('setting/setting');
        $this->load->model('tool/image');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

            $this->model_setting_setting->editSetting('ykcompany', $this->request->post);     
                    
            $this->session->data['success'] = $this->language->get('text_success');

            $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));

        }
                
        $this->data['heading_title'] = $this->language->get('heading_title');
        $this->data['text_image_manager'] = $this->language->get('text_image_manager');
        $this->data['text_browse'] = $this->language->get('text_browse');
        $this->data['text_clear'] = $this->language->get('text_clear'); 
        $this->data['no_image'] = '';

        $this->data['text_enabled'] = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');
        $this->data['text_content_top'] = $this->language->get('text_content_top');
        $this->data['text_content_bottom'] = $this->language->get('text_content_bottom');       
        $this->data['text_column_left'] = $this->language->get('text_column_left');
        $this->data['text_column_right'] = $this->language->get('text_column_right');
        $this->data['entry_description'] = $this->language->get('entry_description');
        $this->data['entry_title'] = $this->language->get('entry_title');
        $this->data['entry_tabs'] = $this->language->get('entry_tabs');
        $this->data['entry_banner'] = $this->language->get('entry_banner');
        $this->data['entry_limit'] = $this->language->get('entry_limit'); 
        $this->data['entry_carousel'] = $this->language->get('entry_carousel'); 
        
        $this->data['entry_layout'] = $this->language->get('entry_layout');
        $this->data['entry_position'] = $this->language->get('entry_position');
        $this->data['entry_status'] = $this->language->get('entry_status');
        $this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
        $this->data['entry_category'] = $this->language->get( 'entry_category' );
        $this->data['entry_lateast_limit'] = $this->language->get( 'entry_lateast_limit' );

        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');
        $this->data['button_add_module'] = $this->language->get('button_add_module');
        $this->data['button_remove'] = $this->language->get('button_remove');
        
        
        $this->load->model('localisation/language');
        $this->data['tab_module'] = $this->language->get('tab_module');
        $this->data['languages'] = $this->model_localisation_language->getLanguages();
        $this->data['token'] = $this->session->data['token'];
        
        
        $this->data['positions'] = array( 
              'mainmenu',
              'slideshow',
              'promotion',
              'showcase',
              'content_top',
              'column_left',
              'column_right',
              'content_bottom',
              'mass_bottom',
              'footer_top',
              'footer_center',
              'footer_bottom'
        );
        
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }
        
        if (isset($this->error['dimension'])) {
            $this->data['error_dimension'] = $this->error['dimension'];
        } else {
            $this->data['error_dimension'] = array();
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
            'href'      => $this->url->link('module/ykcompany', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
        
        $this->data['action'] = $this->url->link('module/ykcompany', 'token=' . $this->session->data['token'], 'SSL');
        
        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
        
        $this->data['modules'] = array();
        
        if (isset($this->request->post['ykcompany_module'])) {
            $this->data['modules'] = $this->request->post['ykcompany_module'];
        } elseif ($this->config->get('ykcompany_module')) { 
            $this->data['modules'] = $this->config->get('ykcompany_module');
        }   
        $this->load->model('extension/company_group');
        $company_group = $this->model_extension_company_group->getCompanyGroups();
        foreach ($company_group as $key => $value) {
            $company_group[$key]['name'] = $this->language->get('text_company').' -> '.$value['name'];
        }
        $this->data['company_groups'] = $company_group;

        $this->load->model('design/layout');
        
        $this->data['layouts'] = array();
        $this->data['layouts'][] = array('layout_id'=>99999, 'name' => $this->language->get('all_page') );
        
        $this->data['layouts'] = array_merge($this->data['layouts'],$this->model_design_layout->getLayouts());

        $this->template = 'module/ykcompany.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
                
        $this->response->setOutput($this->render());
    }
    
    protected function validate() {
        if (!$this->user->hasPermission('modify', 'module/ykcompany')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
          
                        
        if (!$this->error) {
            return true;
        } else {
            return false;
        }   
    }
}