<?php
class ControllerAccountBind extends Controller {
	private $error = array();


    public function index() {
        if (!$this->customer->isLogged()) {
            $this->session->data['redirect'] = $this->url->link('account/company', '', 'SSL');

            $this->redirect($this->url->link('account/login', '', 'SSL'));
        }

        $this->language->load('account/bind');
        
        $this->document->setTitle($this->language->get('heading_title'));
        $this->load->model('service/company');
        
        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['action'] = $this->url->link('account/bind', '', 'SSL');
        $this->data['step'] = 'pwd';

        $company_id = $this->customer->isCompany();
        if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate()) {            
            $this->data['step'] = 'sms';
            $this->data['action'] = $this->url->link('account/bind/sms', '', 'SSL');
        }

        if(isset($this->session->data['step'])){
            switch ($this->session->data['step']) {
                case 'sms':
                    $this->data['step'] = 'sms';
                    $this->data['action'] = $this->url->link('account/bind/sms', '', 'SSL');
                    break;
                case 'success':
                    $this->data['step'] = 'success';
                    break;
            }
        }
        
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }  

        if (isset($this->session->data['step'])) {
            $this->data['step'] = $this->session->data['step'];
            $this->data['action'] = $this->url->link('account/bind/sms', '', 'SSL');
            unset($this->session->data['step']);
        }

        $this->data['mobile_phone'] = substr_replace($this->customer->getMobilePhone(),'****', 3,4);
        $company_info = $this->model_service_company->getCompany($company_id);

        $this->data['captcha'] = $this->url->link('common/tool/captcha','','ssl');
        $this->template = $this->config->get('config_template') . '/template/account/bind.tpl';
        $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/footer',
            'common/header' 
        );
                        
        $this->response->setOutput($this->render());    
    }

    public function sms(){
        $mobile_phone = isset($this->request->post['phone']) ? $this->request->post['phone'] : false;
        $sms = isset($this->request->post['sms']) ? $this->request->post['sms'] : false;
        $this->load->model('account/customer');
        $sms_log = $this->model_account_customer->getSMS($mobile_phone);

        if($sms && !empty($sms_log['sms']) && ($sms_log['sms'] == $sms) ) {
            $this->model_account_customer->editMobilePhone($mobile_phone);
            $this->session->data['step'] = 'success';
            $this->redirect($this->url->link('account/bind','','SSL'));
        }else{
            $this->session->data['step'] = 'sms';
            $this->redirect($this->url->link('account/bind'));
        }
    }

    public function validate(){

        $captcha = isset($this->session->data['captcha']) ? $this->session->data['captcha'] : false;
        $_captcha = isset($this->request->post['captcha']) ? $this->request->post['captcha'] : false;
        if(!$captcha || !$_captcha || $captcha != $_captcha ){
            $this->error['captcha'] = $this->language->get('error_captcha');
        }
        $this->load->model('account/customer');
        $pwd = isset($this->request->post['pwd']) ? $this->request->post['pwd'] : false;
        $res = $this->model_account_customer->validatePassword($pwd);
        if(!$pwd || !$res){
            $this->error['pwd'] = $this->language->get('error_pwd');
        }
        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }
}