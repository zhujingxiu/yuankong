<?php 
class ControllerServiceCommonweal extends Controller {
	private $error = array();
		
	public function index() {
        $this->language->load('service/commonweal');

        $this->document->setTitle($this->language->get('heading_title'));
        $this->document->addStyle('market/view/theme/yuankong/stylesheet/yk_zt.css');
        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home'),         
            'separator' => false
        );                 
        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('service/commonweal', '', 'SSL'),            
            'separator' => $this->language->get('text_separator')
        );

        $this->template = $this->config->get('config_template') . '/template/service/commonweal.tpl';
        
        $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/content_top',
            'common/content_bottom',
            'common/footer',
            'common/header' 
        );
                        
        $this->response->setOutput($this->render());    
	}

}