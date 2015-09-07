<?php 
class ControllerServiceAssistant extends Controller {
    private $error = array();
        
    public function index() {
        $this->language->load('service/assistant');

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
            'href'      => $this->url->link('service/assistant', '', 'SSL'),            
            'separator' => $this->language->get('text_separator')
        );
        $this->load->model('catalog/information');
        $this->data['helps'] = $this->model_catalog_information->getTopHelps(15);
        $this->template = $this->config->get('config_template') . '/template/service/assistant.tpl';
        
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
    public function lecture() {
        $this->language->load('service/assistant');

        $this->document->setTitle($this->language->get('title_lecture'));
        $this->document->addStyle('market/view/theme/yuankong/stylesheet/yk_zt.css');
        $this->load->model('tool/common');
        $page = $this->model_tool_common->getPage('service/assistant/lecture');
        $this->data['page_content'] = empty($page['text']) ? '' : html_entity_decode($page['text'],ENT_QUOTES,'UTF-8');
        $this->template = $this->config->get('config_template') . '/template/service/static_page.tpl';
        
        $this->children = array(
            'common/footer',
            'common/header' 
        );
                        
        $this->response->setOutput($this->render());                
    }

    public function expert() {
        $this->language->load('service/assistant');

        $this->document->setTitle($this->language->get('title_expert'));
        $this->document->addStyle('market/view/theme/yuankong/stylesheet/yk_zt.css');
        //$this->load->model('tool/common');
        //$page = $this->model_tool_common->getPage('service/assistant/expert');
        //$this->data['page_content'] = empty($page['text']) ? '' : html_entity_decode($page['text'],ENT_QUOTES,'UTF-8');
        $this->load->model('catalog/information');
        $this->data['helps'] = $this->model_catalog_information->getTopHelps(15);
        $this->template = $this->config->get('config_template') . '/template/service/expert.tpl';
        $this->children = array(
            'common/footer',
            'common/header',
            'module/mini_login'
        );
                        
        $this->response->setOutput($this->render()); 
    }

    public function quoted_price() {
        $this->language->load('service/assistant');

        $this->document->setTitle($this->language->get('title_quoted'));
        $this->document->addStyle('market/view/theme/yuankong/stylesheet/yk_zt.css');
        $this->document->addScript($this->area_js());

        $this->data['home'] = $this->url->link('common/home');
        $this->data['action'] = $this->url->link('service/assistant/quoted');

        $this->template = $this->config->get('config_template') . '/template/service/quoted_price.tpl';
        
        $this->children = array(
            'module/mini_login',
            'common/footer',
            'common/header' 
        );
                        
        $this->response->setOutput($this->render());                
    }

    public function quoted() {

        $this->language->load('service/assistant');

        $this->load->model('tool/common');
            
        if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
            
            $this->load->model('tool/common');
            $time = $this->model_tool_common->getQuotedLimit($this->customer->getId());

            if($time < 4 ){
                $this->model_tool_common->addQuoted($this->request->post); 
                $json = array('status'=>1,'msg'=>$this->language->get('text_apply_success'));   
            }else{
                $json = array('status'=>0,'error'=>'已达到申请的上限，每天仅可申请4次');
            }            
        }
        $this->response->setOutput(json_encode($json));
    }

    public function apply() {

        $this->language->load('service/assistant');

        $this->load->model('service/assistant');
            
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateApply()) {
            $this->model_service_company->addCompanyRequest($this->request->post);
            
            $this->session->data['success'] = $this->language->get('text_apply_success');
            $this->session->data['apply_phone'] = (isset($this->request->post['company_id']) ? $this->request->post['company_id'] : 0 ) . '_' . $this->request->post['mobile_phone'];
            $this->session->data['apply_time'] = time();

            if(isset($this->request->post['redirect'])){
                $this->redirect(htmlspecialchars_decode($this->request->post['redirect'])); 
            }
            $json = array('status'=>1,'msg'=>$this->language->get('text_apply_success'));
        }else{
            $json = array('status'=>0,'error'=>implode("<br>", $this->error));
        }
        $this->response->setOutput(json_encode($json));

    }

    protected function validateApply() {
        if (!isset($this->request->post['mobile_phone']) || !isMobile($this->request->post['mobile_phone'])) {
            $this->error['mobile_phone'] = $this->language->get('error_mobile_phone');
        }
        if(!isset($this->request->post['group_id'])){
            $this->request->post['group_id'] = 0;
        }
        if ((utf8_strlen($this->request->post['account']) < 2) || (utf8_strlen($this->request->post['account']) > 128)) {
            $this->error['account'] = $this->language->get('error_account');
        }
        if(isset($this->session->data['apply_phone']) && $this->session->data['apply_phone'] == ((isset($this->request->post['company_id']) ? $this->request->post['company_id'] : 0 )  . '_' .$this->request->post['mobile_phone']) && ($this->session->data['apply_time'] - time() < 3600)){
            $this->error['repeat'] = $this->language->get('error_repeat');  
        }
        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    private function area_js(){
        $file = TPL_JS.'area.js';
        if(!file_exists($file)){
            $this->load->model('localisation/area');
            $areas = $this->model_localisation_area->getAreas();
            $area_rows_group_by_pid = $this->array_group($areas, 'pid');

            $address = array();
            foreach ($area_rows_group_by_pid as $pid => $item) {
                if ($pid == 0) {
                    
                    $item = array_filter($item, function($item){
                        return $item['pid'] == 0;
                    });
                }
                $address['name'.$pid] = array_keys($this->array_group($item, 'name'));
                $address['code'.$pid] = array_keys($this->array_group($item, 'area_id'));
            }
            file_put_contents($file, 'var area = ' . json_encode_ex($address) . ';');
            
        }
        return $file;
    } 

    private function array_group($array, $key, $limit = false){
        if (empty ($array) || !is_array($array)){
            return $array;
        }

        $_result = array ();
        foreach ($array as $item) {
            if ((isset($item[$key]))) {
                $_result[(string)$item[$key]][] = $item;
            } else {
                $_result[count($_result)][] = $item;
            }
        }
        if (!$limit) {
            return $_result;
        }

        $result = array ();
        foreach ($_result as $k => $item) {
            $result[$k] = $item[0];
        }
        return $result;
    }
}