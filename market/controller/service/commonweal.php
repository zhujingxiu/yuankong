<?php 
class ControllerServiceCommonweal extends Controller {
	private $error = array();
		
	public function index() {
        $this->language->load('service/commonweal');

        $this->document->setTitle($this->language->get('heading_title'));
        $this->document->addStyle('market/view/theme/yuankong/stylesheet/yk_zt.css');

        $this->load->model('tool/common');
        $page = $this->model_tool_common->getPage('service/commonweal');
        $this->data['page_content'] = empty($page['text']) ? '' : html_entity_decode($page['text'],ENT_QUOTES,'UTF-8');
        $this->template = $this->config->get('config_template') . '/template/service/static_page.tpl';
        
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