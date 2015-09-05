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

        $this->data['bind'] = $this->url->link('account/bind', '', 'SSL');
        $this->data['action'] = $this->url->link('account/company/description', '', 'SSL');

        $company_id = $this->customer->isCompany();
        if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validateDescription()) {
            $this->model_service_company->editDescription($company_id,$this->request->post); 
            $this->session->data['success']  = $this->language->get('text_success_description');
            $this->redirect($this->url->link('account/company/description'),'','SSL');
        }
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }  

        if (isset($this->session->data['success'])) {
            $this->data['error_success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        } else {
            $this->data['error_success'] = '';
        }  

        $this->data['mobile_phone'] = substr_replace($this->customer->getMobilePhone(),'****', 3,4);
        $company_info = $this->model_service_company->getCompany($company_id);


        $this->template = $this->config->get('config_template') . '/template/account/bind.tpl';
        $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/footer',
            'common/header' 
        );
                        
        $this->response->setOutput($this->render());    
    }



    public function validateDescription(){
        if ((utf8_strlen($this->request->post['description']) < 1) || (utf8_strlen($this->request->post['description']) > 512)) {
            $this->error['description'] = $this->language->get('error_description');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }


}
