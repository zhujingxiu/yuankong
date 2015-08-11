<?php 
class ControllerSaleCompanyRequest extends Controller { 
    private $error = array();
   
    public function index() {
        $this->language->load('sale/company_request');
    
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('sale/company_request');
        
        $this->getList();
    }
              
    public function insert() {
        $this->language->load('sale/company_request');
    
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('sale/company_request');
            
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_sale_company_request->addCompanyRequest($this->request->post);
            
            $this->session->data['success'] = $this->language->get('text_success');

            $url = '';
            
            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }
                        
            $this->redirect($this->url->link('sale/company_request', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }
    
        $this->getForm();
    }

    public function update() {
        $this->language->load('sale/company_request');
    
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('sale/company_request');
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_sale_company_request->editCompanyRequest($this->request->get['request_id'], $this->request->post);
            
            $this->session->data['success'] = $this->language->get('text_success');

            $url = '';
            
            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }
            
            $this->redirect($this->url->link('sale/company_request', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }
    
        $this->getForm();
    }

    public function delete() {
        $this->language->load('sale/company_request');
    
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('sale/company_request');
        
        if (isset($this->request->post['selected']) && $this->validateDelete()) {
            foreach ($this->request->post['selected'] as $request_id) {
                $this->model_sale_company_request->deleteCompanyRequest($request_id);
            }
                        
            $this->session->data['success'] = $this->language->get('text_success');

            $url = '';
            
            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }

            if (isset($this->request->get['page'])) {
                $url .= '&page=' . $this->request->get['page'];
            }
            
            $this->redirect($this->url->link('sale/company_request', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }
    
        $this->getList();
    }
    
    protected function getList() {
         if (isset($this->request->get['filter_account'])) {
            $filter_account = $this->request->get['filter_account'];
        } else {
            $filter_account = null;
        }

        if (isset($this->request->get['filter_mobile_phone'])) {
            $filter_mobile_phone = $this->request->get['filter_mobile_phone'];
        } else {
            $filter_mobile_phone = null;
        }
        
        if (isset($this->request->get['filter_status'])) {
            $filter_status = $this->request->get['filter_status'];
        } else {
            $filter_status = null;
        }
        
        if (isset($this->request->get['filter_company'])) {
            $filter_company = $this->request->get['filter_company'];
        } else {
            $filter_company = null;
        }
        
        if (isset($this->request->get['filter_date_added'])) {
            $filter_date_added = $this->request->get['filter_date_added'];
        } else {
            $filter_date_added = null;
        }
        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'cr.date_added';
        }
        
        if (isset($this->request->get['order'])) {
            $order = $this->request->get['order'];
        } else {
            $order = 'DESC';
        }
        
        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }
                
        $url = '';
        if (isset($this->request->get['filter_acount'])) {
            $url .= '&filter_acount=' . urlencode(html_entity_decode($this->request->get['filter_acount'], ENT_QUOTES, 'UTF-8'));
        }
        if (isset($this->request->get['filter_mobile_phone'])) {
            $url .= '&filter_mobile_phone=' . urlencode(html_entity_decode($this->request->get['filter_mobile_phone'], ENT_QUOTES, 'UTF-8'));
        }
                        
        if (isset($this->request->get['filter_status'])) {
            $url .= '&filter_status=' . $this->request->get['filter_status'];
        }

        if (isset($this->request->get['filter_company'])) {
            $url .= '&filter_company=' . urlencode(html_entity_decode($this->request->get['filter_company'], ENT_QUOTES, 'UTF-8'));
        }
 
        if (isset($this->request->get['filter_date_added'])) {
            $url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
        }            
        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }
        
        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('sale/company_request', 'token=' . $this->session->data['token'] . $url, 'SSL'),
            'separator' => ' :: '
        );
                            
        $this->data['insert'] = $this->url->link('sale/company_request/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
        $this->data['delete'] = $this->url->link('sale/company_request/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');    

        $this->data['requests'] = array();

        $data = array(
            'filter_mobile_phone'=> $filter_mobile_phone, 
            'filter_account' => $filter_account, 
            'filter_status'     => $filter_status, 
            'filter_company'   => $filter_company, 
            'filter_date_added' => $filter_date_added,
            'sort'  => $sort,
            'order' => $order,
            'start' => ($page - 1) * $this->config->get('config_admin_limit'),
            'limit' => $this->config->get('config_admin_limit')
        );
        
        $company_request_total = $this->model_sale_company_request->getTotalCompanyRequests($data);
    
        $results = $this->model_sale_company_request->getCompanyRequests($data);
 
        foreach ($results as $result) {
            $action = array();
            
            $action[] = array(
                'text' => $this->language->get('text_edit'),
                'href' => $this->url->link('sale/company_request/update', 'token=' . $this->session->data['token'] . '&request_id=' . $result['request_id'] . $url, 'SSL')
            );
                        
            $this->data['requests'][] = array(
                'request_id'         => $result['request_id'],
                'account'            => $result['account'],
                'mobile_phone'       => $result['mobile_phone'],
                'company'            => $result['company'] ,
                'status_text'        => !$result['status'] ? $this->language->get('text_pending') : $this->language->get('text_completed'),
                'date_added'         => date('Y-m-d H:i:s',strtotime($result['date_added'])),
                'selected'           => isset($this->request->post['selected']) && in_array($result['request_id'], $this->request->post['selected']),
                'action'             => $action
            );
        }   
    
        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_no_results'] = $this->language->get('text_no_results');
        $this->data['text_pending'] = $this->language->get('text_pending');
        $this->data['text_completed'] = $this->language->get('text_completed');

        $this->data['column_account'] = $this->language->get('column_account');
        $this->data['column_mobile_phone'] = $this->language->get('column_mobile_phone');
        $this->data['column_company'] = $this->language->get('column_company');
        $this->data['column_status'] = $this->language->get('column_status');
        $this->data['column_date_added'] = $this->language->get('column_date_added');
        $this->data['column_action'] = $this->language->get('column_action');       
        
        $this->data['button_insert'] = $this->language->get('button_insert');
        $this->data['button_filter'] = $this->language->get('button_filter');
        $this->data['button_delete'] = $this->language->get('button_delete');
 
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }
        
        if (isset($this->session->data['success'])) {
            $this->data['success'] = $this->session->data['success'];
        
            unset($this->session->data['success']);
        } else {
            $this->data['success'] = '';
        }

        $url = '';
        if (isset($this->request->get['filter_acount'])) {
            $url .= '&filter_acount=' . urlencode(html_entity_decode($this->request->get['filter_acount'], ENT_QUOTES, 'UTF-8'));
        }
        if (isset($this->request->get['filter_mobile_phone'])) {
            $url .= '&filter_mobile_phone=' . urlencode(html_entity_decode($this->request->get['filter_mobile_phone'], ENT_QUOTES, 'UTF-8'));
        }
                        
        if (isset($this->request->get['filter_status'])) {
            $url .= '&filter_status=' . $this->request->get['filter_status'];
        }

        if (isset($this->request->get['filter_company'])) {
            $url .= '&filter_company=' . urlencode(html_entity_decode($this->request->get['filter_company'], ENT_QUOTES, 'UTF-8'));
        }
 
        if (isset($this->request->get['filter_date_added'])) {
            $url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
        }
        if ($order == 'ASC') {
            $url .= '&order=DESC';
        } else {
            $url .= '&order=ASC';
        }

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }
        
        $this->data['sort_account'] = $this->url->link('sale/company_request', 'token=' . $this->session->data['token'] . '&sort=cr.account' . $url, 'SSL');
        $this->data['sort_mobile_phone'] = $this->url->link('sale/company_request', 'token=' . $this->session->data['token'] . '&sort=cr.mobile_phone' . $url, 'SSL');
        $this->data['sort_company'] = $this->url->link('sale/company_request', 'token=' . $this->session->data['token'] . '&sort=cr.company_id' . $url, 'SSL');
        $this->data['sort_status'] = $this->url->link('sale/company_request', 'token=' . $this->session->data['token'] . '&sort=cr.status' . $url, 'SSL');
        $this->data['sort_date_added'] = $this->url->link('sale/company_request', 'token=' . $this->session->data['token'] . '&sort=cr.date_added' . $url, 'SSL');
        
        $url = '';
        if (isset($this->request->get['filter_acount'])) {
            $url .= '&filter_acount=' . urlencode(html_entity_decode($this->request->get['filter_acount'], ENT_QUOTES, 'UTF-8'));
        }
        if (isset($this->request->get['filter_mobile_phone'])) {
            $url .= '&filter_mobile_phone=' . urlencode(html_entity_decode($this->request->get['filter_mobile_phone'], ENT_QUOTES, 'UTF-8'));
        }
                        
        if (isset($this->request->get['filter_status'])) {
            $url .= '&filter_status=' . $this->request->get['filter_status'];
        }

        if (isset($this->request->get['filter_company'])) {
            $url .= '&filter_company=' . urlencode(html_entity_decode($this->request->get['filter_company'], ENT_QUOTES, 'UTF-8'));
        }
 
        if (isset($this->request->get['filter_date_added'])) {
            $url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
        }
        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }
                                                
        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        $pagination = new Pagination();
        $pagination->total = $company_request_total;
        $pagination->page = $page;
        $pagination->limit = $this->config->get('config_admin_limit');
        $pagination->text = $this->language->get('text_pagination');
        $pagination->url = $this->url->link('sale/company_request', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
            
        $this->data['pagination'] = $pagination->render();

        $this->data['sort'] = $sort;
        $this->data['order'] = $order;
        $this->data['filter_company'] = $filter_company;
        $this->data['filter_mobile_phone'] = $filter_mobile_phone;
        $this->data['filter_status'] = $filter_status;
        $this->data['filter_account'] = $filter_account;
        $this->data['filter_date_added'] = $filter_date_added;
        $this->template = 'sale/company_request_list.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
                
        $this->response->setOutput($this->render());
    }
  
    protected function getForm() {
        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['entry_account'] = $this->language->get('entry_account');
        $this->data['entry_mobile_phone'] = $this->language->get('entry_mobile_phone');
        $this->data['entry_status'] = $this->language->get('entry_status');
        $this->data['entry_note'] = $this->language->get('entry_note');
        $this->data['entry_company'] = $this->language->get('entry_company');

        $this->data['text_none'] = $this->language->get('text_none');
        $this->data['text_completed'] = $this->language->get('text_completed');
        $this->data['text_pending'] = $this->language->get('text_pending');

        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');
    
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }

        if (isset($this->error['account'])) {
            $this->data['error_account'] = $this->error['account'];
        } else {
            $this->data['error_account'] = '';
        }
        if (isset($this->error['mobile_phone'])) {
            $this->data['error_mobile_phone'] = $this->error['mobile_phone'];
        } else {
            $this->data['error_mobile_phone'] = '';
        }
        $url = '';
        if (isset($this->request->get['filter_acount'])) {
            $url .= '&filter_acount=' . urlencode(html_entity_decode($this->request->get['filter_acount'], ENT_QUOTES, 'UTF-8'));
        }
        if (isset($this->request->get['filter_mobile_phone'])) {
            $url .= '&filter_mobile_phone=' . urlencode(html_entity_decode($this->request->get['filter_mobile_phone'], ENT_QUOTES, 'UTF-8'));
        }
                        
        if (isset($this->request->get['filter_status'])) {
            $url .= '&filter_status=' . $this->request->get['filter_status'];
        }

        if (isset($this->request->get['filter_company'])) {
            $url .= '&filter_company=' . urlencode(html_entity_decode($this->request->get['filter_company'], ENT_QUOTES, 'UTF-8'));
        }
 
        if (isset($this->request->get['filter_date_added'])) {
            $url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
        }           
        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }
        
        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),            
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('sale/company_request', 'token=' . $this->session->data['token'] . $url, 'SSL'),
            'separator' => ' :: '
        );
        
        if (!isset($this->request->get['request_id'])) {
            $this->data['action'] = $this->url->link('sale/company_request/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
        } else {
            $this->data['action'] = $this->url->link('sale/company_request/update', 'token=' . $this->session->data['token'] . '&request_id=' . $this->request->get['request_id'] . $url, 'SSL');
        }
            
        $this->data['cancel'] = $this->url->link('sale/company_request', 'token=' . $this->session->data['token'] . $url, 'SSL');

        if (isset($this->request->get['request_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $company_request_info = $this->model_sale_company_request->getCompanyRequest($this->request->get['request_id']);
        }
        if (isset($this->request->post['account'])) {
            $this->data['account'] = $this->request->post['account'];
        } elseif (!empty($company_request_info['account'])) {
            $this->data['account'] = $company_request_info['account'];
        } else {
            $this->data['account'] = '';
        }        
    
        if (isset($this->request->post['company_id'])) {
            $this->data['company_id'] = $this->request->post['company_id'];
        } elseif (!empty($company_request_info['company_id'])) {
            $this->data['company_id'] = $company_request_info['company_id'];
        } else {
            $this->data['company_id'] = '';
        }

        if (isset($this->request->post['status'])) {
            $this->data['status'] = $this->request->post['status'];
        } elseif (isset($company_request_info['status'])) {
            $this->data['status'] = $company_request_info['status'];
        } else {
            $this->data['status'] = 0;
        }

        if (isset($this->request->post['mobile_phone'])) {
            $this->data['mobile_phone'] = $this->request->post['mobile_phone'];
        } elseif (!empty($company_request_info['mobile_phone'])) {
            $this->data['mobile_phone'] = $company_request_info['mobile_phone'];
        } else {
            $this->data['mobile_phone'] = '';
        }

        if (isset($this->request->post['note'])) {
            $this->data['note'] = $this->request->post['note'];
        } elseif (!empty($company_request_info['note'])) {
            $this->data['note'] = $company_request_info['note'];
        } else {
            $this->data['note'] = '';
        }

        $this->load->model('sale/company');
        $this->data['companies'] = $this->model_sale_company->getApprovedCompanies();
   
        $this->template = 'sale/company_request_form.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
                
        $this->response->setOutput($this->render());    
    }
    
    protected function validateForm() {
        if (!$this->user->hasPermission('modify', 'sale/company_request')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
    
        
        if ((utf8_strlen($this->request->post['account']) < 1) || (utf8_strlen($this->request->post['account']) > 64)) {
            $this->error['account'] = $this->language->get('error_account');
        }
        
        if ((utf8_strlen($this->request->post['mobile_phone']) < 1) || !isMobile($this->request->post['mobile_phone'])) {
            $this->error['mobile_phone'] = $this->language->get('error_mobile_phone');
        }
        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    protected function validateDelete() {
        if (!$this->user->hasPermission('modify', 'sale/company_request')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        if (!$this->error) { 
            return true;
        } else {
            return false;
        }
    }     
}