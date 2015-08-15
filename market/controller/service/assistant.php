<?php 
class ControllerServiceAssistant extends Controller {
    private $error = array();
        
    public function index() {
        $this->language->load('service/assistant');
        $this->load->model('service/assistant');

        $this->document->setTitle($this->language->get('heading_title'));
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
    public function bidding() {
        $this->language->load('service/assistant');
        $this->load->model('service/assistant');

        $this->document->setTitle($this->language->get('heading_title'));
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

        $this->template = $this->config->get('config_template') . '/template/service/bidding.tpl';
        
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

    public function expert() {
        $this->language->load('service/assistant');
        $this->load->model('service/assistant');

        $this->document->setTitle($this->language->get('heading_title'));
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

        $this->template = $this->config->get('config_template') . '/template/service/expert.tpl';
        
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

    public function quoted_price() {
        $this->language->load('service/assistant');
        $this->load->model('service/assistant');

        $this->document->setTitle($this->language->get('heading_title'));
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

        $this->template = $this->config->get('config_template') . '/template/service/quoted_price.tpl';
        
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
}