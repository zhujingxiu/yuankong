<?php  
class ControllerCommonProfile extends Controller {  
    private $error = array();
   
    public function index() {
        $this->language->load('user/user');

        $this->document->setTitle($this->language->get('heading_title'));
    
        $this->load->model('user/user');
        
        $this->data['heading_title'] = $this->language->get('heading_title');

        $this->data['text_enabled'] = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');
        
        $this->data['entry_username'] = $this->language->get('entry_username');
        $this->data['entry_nickname'] = $this->language->get('entry_nickname');
        $this->data['entry_password'] = $this->language->get('entry_password');
        $this->data['entry_confirm'] = $this->language->get('entry_confirm');
        $this->data['entry_firstname'] = $this->language->get('entry_firstname');
        $this->data['entry_lastname'] = $this->language->get('entry_lastname');
        $this->data['entry_email'] = $this->language->get('entry_email');
        $this->data['entry_user_group'] = $this->language->get('entry_user_group');
        $this->data['entry_status'] = $this->language->get('entry_status');
        $this->data['entry_captcha'] = $this->language->get('entry_captcha');

        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');
    
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

        if (isset($this->error['username'])) {
            $this->data['error_username'] = $this->error['username'];
        } else {
            $this->data['error_username'] = '';
        }

        if (isset($this->error['password'])) {
            $this->data['error_password'] = $this->error['password'];
        } else {
            $this->data['error_password'] = '';
        }
        
        if (isset($this->error['confirm'])) {
            $this->data['error_confirm'] = $this->error['confirm'];
        } else {
            $this->data['error_confirm'] = '';
        }

        if (isset($this->error['nickname'])) {
            $this->data['error_nickname'] = $this->error['nickname'];
        } else {
            $this->data['error_nickname'] = '';
        }
        
        if (isset($this->error['firstname'])) {
            $this->data['error_firstname'] = $this->error['firstname'];
        } else {
            $this->data['error_firstname'] = '';
        }
        
        if (isset($this->error['lastname'])) {
            $this->data['error_lastname'] = $this->error['lastname'];
        } else {
            $this->data['error_lastname'] = '';
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
            'href'      => $this->url->link('user/user', 'token=' . $this->session->data['token'] . $url, 'SSL'),
            'separator' => ' :: '
        );
        

        $this->data['action'] = $this->url->link('common/profile/update', 'token=' . $this->session->data['token'] . $url, 'SSL');

          
        $this->data['cancel'] = $this->url->link('common/home', 'token=' . $this->session->data['token'] . $url, 'SSL');

        $user_info = $this->model_user_user->getUser($this->user->getId());

        if (isset($this->request->post['username'])) {
            $this->data['username'] = $this->request->post['username'];
        } elseif (!empty($user_info)) {
            $this->data['username'] = $user_info['username'];
        } else {
            $this->data['username'] = '';
        }
  
        if (isset($this->request->post['password'])) {
            $this->data['password'] = $this->request->post['password'];
        } else {
            $this->data['password'] = '';
        }
        
        if (isset($this->request->post['confirm'])) {
            $this->data['confirm'] = $this->request->post['confirm'];
        } else {
            $this->data['confirm'] = '';
        }
        if (isset($this->request->post['nickname'])) {
            $this->data['nickname'] = $this->request->post['nickname'];
        } elseif (!empty($user_info['nickname'])) {
            $this->data['nickname'] = $user_info['nickname'];
        } else {
            $this->data['nickname'] = '';
        }
  
        if (isset($this->request->post['firstname'])) {
            $this->data['firstname'] = $this->request->post['firstname'];
        } elseif (!empty($user_info)) {
            $this->data['firstname'] = $user_info['firstname'];
        } else {
            $this->data['firstname'] = '';
        }

        if (isset($this->request->post['lastname'])) {
            $this->data['lastname'] = $this->request->post['lastname'];
        } elseif (!empty($user_info)) {
            $this->data['lastname'] = $user_info['lastname'];
        } else {
            $this->data['lastname'] = '';
        }
  
        if (isset($this->request->post['email'])) {
            $this->data['email'] = $this->request->post['email'];
        } elseif (!empty($user_info)) {
            $this->data['email'] = $user_info['email'];
        } else {
            $this->data['email'] = '';
        }

        if (isset($this->request->post['user_group_id'])) {
            $this->data['user_group_id'] = $this->request->post['user_group_id'];
        } elseif (!empty($user_info)) {
            $this->data['user_group_id'] = $user_info['user_group_id'];
        } else {
            $this->data['user_group_id'] = '';
        }
        
        $this->load->model('user/user_group');
        
        $this->data['user_groups'] = $this->model_user_user_group->getUserGroups();
 
        if (isset($this->request->post['status'])) {
            $this->data['status'] = $this->request->post['status'];
        } elseif (!empty($user_info)) {
            $this->data['status'] = $user_info['status'];
        } else {
            $this->data['status'] = 0;
        }
        
        $this->template = 'common/profile.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
                
        $this->response->setOutput($this->render());   
    }
   
    public function update() {
        $this->language->load('user/user');

        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->load->model('user/user');
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_user_user->editUser($this->user->getId(), $this->request->post);
            
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
            
            $this->redirect($this->url->link('common/profile', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }
    
    }
    
    protected function validateForm() {
    
        if ((utf8_strlen($this->request->post['username']) < 3) || (utf8_strlen($this->request->post['username']) > 20)) {
            $this->error['username'] = $this->language->get('error_username');
        }
        
        $user_info = $this->model_user_user->getUserByUsername($this->request->post['username']);
        
        if ($user_info && ($this->user->getId() != $user_info['user_id'])) {
            $this->error['warning'] = $this->language->get('error_exists');
        }
        /*
        if ((utf8_strlen($this->request->post['firstname']) < 1) || (utf8_strlen($this->request->post['firstname']) > 32)) {
            $this->error['firstname'] = $this->language->get('error_firstname');
        }

        if ((utf8_strlen($this->request->post['lastname']) < 1) || (utf8_strlen($this->request->post['lastname']) > 32)) {
            $this->error['lastname'] = $this->language->get('error_lastname');
        }
*/
        if (!empty($this->request->post['password'])) {
            if ((utf8_strlen($this->request->post['password']) < 4) || (utf8_strlen($this->request->post['password']) > 20)) {
                $this->error['password'] = $this->language->get('error_password');
            }
    
            if ($this->request->post['password'] != $this->request->post['confirm']) {
                $this->error['confirm'] = $this->language->get('error_confirm');
            }
        }
    
        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }

}