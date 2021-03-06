<?php 
class ControllerSaleCompanyGroup extends Controller { 
    private $error = array();
   
    public function index() {
        $this->language->load('sale/company_group');
    
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('sale/company_group');
        
        $this->getList();
    }
              
    public function insert() {
        $this->language->load('sale/company_group');
    
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('sale/company_group');
            
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_sale_company_group->addCompanyGroup($this->request->post);
            
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
                        
            $this->redirect($this->url->link('sale/company_group', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }
    
        $this->getForm();
    }

    public function update() {
        $this->language->load('sale/company_group');
    
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('sale/company_group');
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_sale_company_group->editCompanyGroup($this->request->get['group_id'], $this->request->post);
            
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
            
            $this->redirect($this->url->link('sale/company_group', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }
    
        $this->getForm();
    }

    public function delete() {
        $this->language->load('sale/company_group');
    
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('sale/company_group');
        
        if (isset($this->request->post['selected']) && $this->validateDelete()) {
            foreach ($this->request->post['selected'] as $group_id) {
                $this->model_sale_company_group->deleteCompanyGroup($group_id);
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
            
            $this->redirect($this->url->link('sale/company_group', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }
    
        $this->getList();
    }
    
    protected function getList() {
        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'sort_order';
        }
        
        if (isset($this->request->get['order'])) {
            $order = $this->request->get['order'];
        } else {
            $order = 'ASC';
        }
        
        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }
                
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

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('sale/company_group', 'token=' . $this->session->data['token'] . $url, 'SSL'),
            'separator' => ' :: '
        );
                            
        $this->data['insert'] = $this->url->link('sale/company_group/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
        $this->data['delete'] = $this->url->link('sale/company_group/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');    

        $this->data['company_groups'] = array();

        $data = array(
            'sort'  => $sort,
            'order' => $order,
            'start' => ($page - 1) * $this->config->get('config_admin_limit'),
            'limit' => $this->config->get('config_admin_limit')
        );
        
        $company_group_total = $this->model_sale_company_group->getTotalCompanyGroups();
    
        $results = $this->model_sale_company_group->getCompanyGroups($data);
 
        foreach ($results as $result) {
            $action = array();
            
            $action[] = array(
                'text' => $this->language->get('text_edit'),
                'href' => $this->url->link('sale/company_group/update', 'token=' . $this->session->data['token'] . '&group_id=' . $result['group_id'] . $url, 'SSL')
            );
                        
            $this->data['company_groups'][] = array(
                'group_id'           => $result['group_id'],
                'name'               => $result['name'],
                'tag'               => $result['tag'],
                'show'               => $result['show'] ? $this->language->get('text_yes') : $this->language->get('text_no'),
                'status_text'        => $result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled'),
                'sort_order'         => $result['sort_order'],
                'selected'           => isset($this->request->post['selected']) && in_array($result['group_id'], $this->request->post['selected']),
                'action'             => $action
            );
        }   
    
        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_no_results'] = $this->language->get('text_no_results');

        $this->data['column_name'] = $this->language->get('column_name');
        $this->data['column_tag'] = $this->language->get('column_tag');
        $this->data['column_show'] = $this->language->get('column_show');
        $this->data['column_status'] = $this->language->get('column_status');
        $this->data['column_sort_order'] = $this->language->get('column_sort_order');
        $this->data['column_action'] = $this->language->get('column_action');       
        
        $this->data['button_insert'] = $this->language->get('button_insert');
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

        if ($order == 'ASC') {
            $url .= '&order=DESC';
        } else {
            $url .= '&order=ASC';
        }

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }
        
        $this->data['sort_name'] = $this->url->link('sale/company_group', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
        $this->data['sort_show'] = $this->url->link('sale/company_group', 'token=' . $this->session->data['token'] . '&sort=show' . $url, 'SSL');
        $this->data['sort_sort_order'] = $this->url->link('sale/company_group', 'token=' . $this->session->data['token'] . '&sort=sort_order' . $url, 'SSL');
        
        $url = '';

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }
                                                
        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        $pagination = new Pagination();
        $pagination->total = $company_group_total;
        $pagination->page = $page;
        $pagination->limit = $this->config->get('config_admin_limit');
        $pagination->text = $this->language->get('text_pagination');
        $pagination->url = $this->url->link('sale/company_group', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
            
        $this->data['pagination'] = $pagination->render();

        $this->data['sort'] = $sort;
        $this->data['order'] = $order;

        $this->template = 'sale/company_group_list.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
                
        $this->response->setOutput($this->render());
    }
  
    protected function getForm() {
        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['entry_name'] = $this->language->get('entry_name');
        $this->data['entry_tag'] = $this->language->get('entry_tag');
        $this->data['entry_show'] = $this->language->get('entry_show');
        $this->data['entry_status'] = $this->language->get('entry_status');
        $this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

        $this->data['text_yes'] = $this->language->get('text_yes');
        $this->data['text_no'] = $this->language->get('text_no');
        $this->data['text_enabled'] = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');

        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');
    
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }

        if (isset($this->error['name'])) {
            $this->data['error_name'] = $this->error['name'];
        } else {
            $this->data['error_name'] = '';
        }
        
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

        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),            
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('sale/company_group', 'token=' . $this->session->data['token'] . $url, 'SSL'),
            'separator' => ' :: '
        );
        
        if (!isset($this->request->get['group_id'])) {
            $this->data['action'] = $this->url->link('sale/company_group/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
        } else {
            $this->data['action'] = $this->url->link('sale/company_group/update', 'token=' . $this->session->data['token'] . '&group_id=' . $this->request->get['group_id'] . $url, 'SSL');
        }
            
        $this->data['cancel'] = $this->url->link('sale/company_group', 'token=' . $this->session->data['token'] . $url, 'SSL');

        if (isset($this->request->get['group_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $company_group_info = $this->model_sale_company_group->getCompanyGroup($this->request->get['group_id']);
        }
                
    
        if (isset($this->request->post['name'])) {
            $this->data['name'] = $this->request->post['name'];
        } elseif (!empty($company_group_info['name'])) {
            $this->data['name'] = $company_group_info['name'];
        } else {
            $this->data['name'] = '';
        }

        if (isset($this->request->post['tag'])) {
            $this->data['tag'] = $this->request->post['tag'];
        } elseif (!empty($company_group_info['tag'])) {
            $this->data['tag'] = $company_group_info['tag'];
        } else {
            $this->data['tag'] = '';
        }

        if (isset($this->request->post['status'])) {
            $this->data['status'] = $this->request->post['status'];
        } elseif (!empty($company_group_info['status'])) {
            $this->data['status'] = $company_group_info['status'];
        } else {
            $this->data['status'] = 1;
        }

        if (isset($this->request->post['show'])) {
            $this->data['show'] = $this->request->post['show'];
        } elseif (!empty($company_group_info['show'])) {
            $this->data['show'] = $company_group_info['show'];
        } else {
            $this->data['show'] = '';
        }

        if (isset($this->request->post['sort_order'])) {
            $this->data['sort_order'] = $this->request->post['sort_order'];
        } elseif (!empty($company_group_info['sort_order'])) {
            $this->data['sort_order'] = $company_group_info['sort_order'];
        } else {
            $this->data['sort_order'] = '';
        }
   
        $this->template = 'sale/company_group_form.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
                
        $this->response->setOutput($this->render());    
    }
    
    protected function validateForm() {
        if (!$this->user->hasPermission('modify', 'sale/company_group')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
    
        
        if ((utf8_strlen($this->request->post['name']) < 1) || (utf8_strlen($this->request->post['name']) > 64)) {
            $this->error['name'] = $this->language->get('error_name');
        }
        
        
        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    protected function validateDelete() {
        if (!$this->user->hasPermission('modify', 'sale/company_group')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        if (!$this->error) { 
            return true;
        } else {
            return false;
        }
    }     
}