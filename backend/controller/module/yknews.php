<?php
class ControllerModuleYknews extends Controller {
    private $error = array(); 
    
    public function index() {   
        $this->language->load('module/yknews');

        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('setting/setting');
                
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_setting_setting->editSetting('yknews', $this->request->post);        
                    
            $this->session->data['success'] = $this->language->get('text_success');
                        
            $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
        }
                
        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_enabled'] = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');
        $this->data['text_none'] = $this->language->get('text_none');
        $this->data['text_content_top'] = $this->language->get('text_content_top');
        $this->data['text_content_bottom'] = $this->language->get('text_content_bottom');       
        $this->data['text_column_left'] = $this->language->get('text_column_left');
        $this->data['text_column_right'] = $this->language->get('text_column_right');

        $this->data['entry_title'] = $this->language->get('entry_title');
        $this->data['entry_group'] = $this->language->get('entry_group');
        $this->data['entry_layout'] = $this->language->get('entry_layout');
        $this->data['entry_position'] = $this->language->get('entry_position');
        $this->data['entry_status'] = $this->language->get('entry_status');
        $this->data['entry_limit'] = $this->language->get('entry_limit');
        $this->data['entry_first_class'] = $this->language->get('entry_first_class');
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
            'href'      => $this->url->link('module/yknews', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
        
        $this->data['action'] = $this->url->link('module/yknews', 'token=' . $this->session->data['token'], 'SSL');
        
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
        
        $d = array(
            'layout_id'=>'',
            'position'=>'',
            'title'=>'',
            'group_id'=>'',
            'status'=>'',
            'sort_order'=>'1',
            'limit'=>6,
            'first_class'=>'ss',
        );

        $this->data['modules'] = array();
        
        if (isset($this->request->post['yknews_module'])) {
            $this->data['modules'] = $this->request->post['yknews_module'];
        } elseif ($this->config->get('yknews_module')) { 
            $this->data['modules'] = $this->config->get('yknews_module');
        }   
        if( !empty($this->data['modules']) ){
             $d = array_merge($d,$this->data['modules'][0]);            
        }
        $this->data['module'] = $d;

        $this->load->model('design/layout');
        $this->data['layouts'][] = array('layout_id'=>99999, 'name' => $this->language->get('all_page') );
        
        $this->data['layouts'] = array_merge($this->data['layouts'],$this->model_design_layout->getLayouts());

        $this->load->model('extension/wiki_group');

        $this->data['groups'] = $this->model_extension_wiki_group->getWikiGroups();
               
        $this->template = 'module/yknews.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
                
        $this->response->setOutput($this->render());
    }
    
    private function validate() {
        if (!$this->user->hasPermission('modify', 'module/yknews')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        if (!$this->error) {
            return true;
        } else {
            return false;
        }   
    }
    
    public function install() {
        $sql = "CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "news` (
          `news_id` int(11) NOT NULL AUTO_INCREMENT,
          `group_id` smallint(4) DEFAULT '0',
          `user_id` int(11) DEFAULT NULL,
          `title` varchar(128) DEFAULT NULL,
          `subtitle` varchar(256) NOT NULL,
          `text` text,
          `status` tinyint(4) DEFAULT '0',
          `is_top` tinyint(4) NOT NULL DEFAULT '0',
          `from` varchar(512) DEFAULT NULL,
          `sort_order` smallint(6) NOT NULL DEFAULT '0',
          `date_added` datetime DEFAULT NULL,
          PRIMARY KEY (`news_id`)
        ) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;";
    $this->db->query($sql);

    $sql = "CREATE TABLE IF NOT EXISTS `yk_news_group` (
          `group_id` int(11) NOT NULL AUTO_INCREMENT,
          `name` varchar(128) DEFAULT NULL,
          `show` tinyint(4) NOT NULL DEFAULT '0',
          `sort_order` int(3) NOT NULL,
          PRIMARY KEY (`group_id`)
        ) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ;";
    $this->db->query($sql);
    $sql = "INSERT INTO `yk_news_group` (`group_id`, `name`, `show`, `sort_order`) VALUES
        (1, '消防法规', 0, 1),
        (2, '消防新闻', 0, 2),
        (3, '官方公告', 0, 3),
        (4, '消防知识', 0, 4),
        (7, '管理培训', 0, 5);";
        $this->db->query($sql);
    }
    
    public function uninstall() {
        $this->db->query("DROP TABLE IF EXISTS `" . DB_PREFIX . "news`");
        $this->db->query("DROP TABLE IF EXISTS " . DB_PREFIX . "news_group");
    }
}