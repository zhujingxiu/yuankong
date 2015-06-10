<?php
class ControllerExtensionLink extends Controller {
    private $error = array();
 
    public function index() {
        $this->language->load('extension/link');

        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('extension/link');
        
        $this->getList();
    } 

    public function insert() {
        $this->language->load('extension/link');

        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('extension/link');
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_extension_link->addLink($this->request->post);
            
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
                        
            $this->redirect($this->url->link('extension/link', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }

        $this->getForm();
    }

    public function update() {
        $this->language->load('extension/link');

        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('extension/link');
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_extension_link->editLink($this->request->get['link_id'], $this->request->post);
            
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
                        
            $this->redirect($this->url->link('extension/link', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }

        $this->getForm();
    }

    public function delete() { 
        $this->language->load('extension/link');

        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('extension/link');

        if (isset($this->request->post['selected']) && $this->validateDelete()) {
            foreach ($this->request->post['selected'] as $link_id) {
                $this->model_extension_link->deleteLink($link_id);
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
                        
            $this->redirect($this->url->link('extension/link', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }

        $this->getList();
    }

    protected function getList() {
        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'l.link_id';
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
            'href'      => $this->url->link('extension/link', 'token=' . $this->session->data['token'] . $url, 'SSL'),
            'separator' => ' :: '
        );
                            
        $this->data['insert'] = $this->url->link('extension/link/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
        $this->data['delete'] = $this->url->link('extension/link/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');  

        $this->data['links'] = array();

        $data = array(
            'sort'  => $sort,
            'order' => $order,
            'start' => ($page - 1) * $this->config->get('config_admin_limit'),
            'limit' => $this->config->get('config_admin_limit')
        );
        
        $link_total = $this->model_extension_link->getTotalLinks();
    
        $results = $this->model_extension_link->getLinks($data);
 
        foreach ($results as $result) {
            $action = array();
                        
            $action[] = array(
                'text' => $this->language->get('text_edit'),
                'href' => $this->url->link('extension/link/update', 'token=' . $this->session->data['token'] . '&link_id=' . $result['link_id'] . $url, 'SSL')
            );
                        
            $this->data['links'][] = array(
                'link_id'    => $result['link_id'],
                'name'    => $result['name'],
                'url'  => $result['url'],
                'sort_order'  => $result['sort_order'],
                'status'     => $result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled'),
                'selected'   => isset($this->request->post['selected']) && in_array($result['link_id'], $this->request->post['selected']),
                'action'     => $action
            );
        }   
    
        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_no_results'] = $this->language->get('text_no_results');

        $this->data['column_name'] = $this->language->get('column_name');
        $this->data['column_url'] = $this->language->get('column_url');
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
        $this->data['sort_name'] = $this->url->link('extension/link', 'token=' . $this->session->data['token'] . '&sort=l.name' . $url, 'SSL');
        $this->data['sort_url'] = $this->url->link('extension/link', 'token=' . $this->session->data['token'] . '&sort=l.url' . $url, 'SSL');
        $this->data['sort_status'] = $this->url->link('extension/link', 'token=' . $this->session->data['token'] . '&sort=l.status' . $url, 'SSL');
        $this->data['sort_sort_order'] = $this->url->link('extension/link', 'token=' . $this->session->data['token'] . '&sort=l.sort_order' . $url, 'SSL');
        
        $url = '';

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }
                                                
        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        $pagination = new Pagination();
        $pagination->total = $link_total;
        $pagination->page = $page;
        $pagination->limit = $this->config->get('config_admin_limit');
        $pagination->text = $this->language->get('text_pagination');
        $pagination->url = $this->url->link('extension/link', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
            
        $this->data['pagination'] = $pagination->render();

        $this->data['sort'] = $sort;
        $this->data['order'] = $order;

        $this->template = 'extension/link_list.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
                
        $this->response->setOutput($this->render());
    }

    protected function getForm() {
        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_enabled'] = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');
        $this->data['text_yes'] = $this->language->get('text_yes');
        $this->data['text_no'] = $this->language->get('text_no');
        $this->data['text_none'] = $this->language->get('text_none');
        $this->data['text_select'] = $this->language->get('text_select');

        $this->data['entry_status'] = $this->language->get('entry_status');
        $this->data['entry_name'] = $this->language->get('entry_name');
        $this->data['entry_url'] = $this->language->get('entry_url');
        $this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

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

        if (isset($this->error['url'])) {
            $this->data['error_url'] = $this->error['url'];
        } else {
            $this->data['error_url'] = '';
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
            'href'      => $this->url->link('extension/link', 'token=' . $this->session->data['token'] . $url, 'SSL'),
            'separator' => ' :: '
        );
                                        
        if (!isset($this->request->get['link_id'])) { 
            $this->data['action'] = $this->url->link('extension/link/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
        } else {
            $this->data['action'] = $this->url->link('extension/link/update', 'token=' . $this->session->data['token'] . '&link_id=' . $this->request->get['link_id'] . $url, 'SSL');
        }
        
        $this->data['cancel'] = $this->url->link('extension/link', 'token=' . $this->session->data['token'] . $url, 'SSL');

        if (isset($this->request->get['link_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $link_info = $this->model_extension_link->getLink($this->request->get['link_id']);
        }
        
        $this->data['token'] = $this->session->data['token'];
            
        if (isset($this->request->post['name'])) {
            $this->data['name'] = $this->request->post['name'];
        } elseif (!empty($link_info['name'])) {
            $this->data['name'] = $link_info['name'];
        } else {
            $this->data['name'] = '';
        }


        if (isset($this->request->post['url'])) {
            $this->data['url'] = $this->request->post['url'];
        } elseif (!empty($link_info['url'])) {
            $this->data['url'] = $link_info['url'];
        } else {
            $this->data['url'] = '';
        }

        if (isset($this->request->post['status'])) {
            $this->data['status'] = $this->request->post['status'];
        } elseif (!empty($link_info['status'])) {
            $this->data['status'] = $link_info['status'];
        } else {
            $this->data['status'] = '';
        }


        if (isset($this->request->post['sort_order'])) {
            $this->data['sort_order'] = $this->request->post['sort_order'];
        } elseif (!empty($link_info['sort_order'])) {
            $this->data['sort_order'] = $link_info['sort_order'];
        } else {
            $this->data['sort_order'] = '';
        }
        $this->template = 'extension/link_form.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
                
        $this->response->setOutput($this->render());
    }
    
    protected function validateForm() {
        if (!$this->user->hasPermission('modify', 'extension/link')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        
        if ((utf8_strlen($this->request->post['name']) < 1) || (utf8_strlen($this->request->post['name']) > 64)) {
            $this->error['name'] = $this->language->get('error_name');
        }
        if ((utf8_strlen($this->request->post['url']) < 1) || (utf8_strlen($this->request->post['url']) > 32)) {
            $this->error['url'] = $this->language->get('error_url');
        }
                
        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

    protected function validateDelete() {
        if (!$this->user->hasPermission('modify', 'extension/link')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }   
}